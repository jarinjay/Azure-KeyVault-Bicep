// PARAMETERS

@minLength(2)
@maxLength(10)

param environment string                                    // Name of the Environment
param virtualNetworkRulesid string                          // Full resource id of a VNET subnet
param location string = resourceGroup().location            // Azure Region to deploy the resource
param accessPoliciesObject object = {}                      // The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault
param ipRulesList array = []                                // The list of IP address rules

// VARIABLES
var env = toLower('${environment}')

// DEPENDANT RESOURCES

module Vault 'modules/keyvault.bicep' = {
  name: 'KeyVault-${env}-deployment'
  params: {
    location: location
    keyvaultName: 'KeyVaultExample-${env}'
    virtualNetworkRulesid: virtualNetworkRulesid
    accessPoliciesObject: accessPoliciesObject
    ipRulesList: ipRulesList
  }
}
