var location = resourceGroup().location

resource rsv1 'Microsoft.RecoveryServices/vaults@2021-08-01' = {
  name: 'rsv1'
  location: location
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}

resource rsv1storage 'Microsoft.RecoveryServices/vaults/backupstorageconfig@2021-10-01' = {
  name: '${rsv1.name}/vaultstorageconfig'
  properties: {
     storageModelType: 'LocallyRedundant'
  } 
}

resource rsv1backuppol 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-10-01' = {
  name: '${rsv1.name}/standard_policy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 2
    schedulePolicy: {
      scheduleRunFrequency: 'Daily'
      scheduleRunDays: null
      scheduleRunTimes: [
        '21:00'
      ]
      schedulePolicyType: 'SimpleSchedulePolicy'
    }
    retentionPolicy: {
      dailySchedule: {
        retentionTimes: [
          '21:00'
        ]
        retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
      weeklySchedule: {
        daysOfTheWeek: [
          'Sunday'
        ]
        retentionTimes: [
          '21:00'
        ]
        retentionDuration: {
          count: 4
          durationType: 'Weeks'
        }
      }
      monthlySchedule: null
      yearlySchedule: null
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
    timeZone: 'UTC'
  }
 }

