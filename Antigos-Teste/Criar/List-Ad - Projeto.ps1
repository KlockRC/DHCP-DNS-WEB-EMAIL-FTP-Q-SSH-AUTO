Import-Csv -Path .\Desktop\Tabela-ListAdd-Formatada.csv -Delimiter ',' -PipelineVariable User  | ForEach-Object -Process {
   $password = 'Senai@127'
   $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force 
   $Names = '{0}.{1}.{2}' -f $User.GivenName, $User.MiddleInitial, $User.Surname
   $AccountNames = ([Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Names))).ToLower()


   $NewAdUserParameters = @{
    GivenName = $User.GivenName
    Surname = $User.Surname
    DisplayName = ('{0}.{1}' -f $User.GivenName, $User.Surname)
    Name = $AccountNames
    Description = 'Automação List AD'
    AccountPassword = $securePassword
    Department = $User.Department
    Path = 'OU={0},OU=LOGJANDIRA_CORP, {1}' -f $User.Department, $((Get-ADDomain).DistinguishedName)
    Enabled = $true
    UserPrincipalName = '{0}.{1}' -f $AccountNames, $((Get-ADDomain).DNSRoot)
    ChangePasswordAtLogon = $false
    OtherAttributes = @{
        telephoneNumber = ('+{0} {1}' -f $User.TelephoneCountryCode, $User.TelephoneNumber)
        }
    State = $User.State
    City = $User.City
    StreetAddress = $User.StreetAddress
    Country = $User.Country
    Title = $User.Title
    Company = $User.Company
    Verbose = $true
   }

    New-AdUser @NewAdUserParameters
}                                

