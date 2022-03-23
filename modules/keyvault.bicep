// PARAMETERS

param location string = resourceGroup().location            // Azure Region to deploy the resource
param keyvaultName string                                   // Name of the Key Vault 
param virtualNetworkRulesid string                          // Full resource id of a VNET subnet
param accessPoliciesObject object = {}                      // The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault
param secretsPermissions array = [                          // Set Secrets Permissions
  'list'
  'get'
]

// Add Keys and Certificates Permissions accordingly here

@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'                          // skuName
param ipRulesList array = []                               // The list of IP address rules

// To create a Microsoft.KeyVault/vaults resource

resource Vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: keyvaultName
  location: location
  // tags: {
  //   tagName1: 'tagValue1'
  //   tagName2: 'tagValue2'
  // }
  properties: {
    accessPolicies: [for accessPolicy in accessPoliciesObject.accessPolicies: {
        tenantId: subscription().tenantId
        objectId: accessPolicy.objectId
        permissions: {
          secrets: secretsPermissions
    }
  }]
    createMode: 'default'
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enableSoftDelete: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: [for ip in ipRulesList: {
        value: ip
       }]
      virtualNetworkRules: [
        {
          id : virtualNetworkRulesid
        }
      ]
    }
    //provisioningState: 'string'
    publicNetworkAccess: 'disabled'
    sku: {
      family: 'A'
      name: skuName
    }
    softDeleteRetentionInDays: 7
    tenantId: subscription().tenantId
    // vaultUri: 'string'
  }
}
output keyvaultId string = Vault.id
