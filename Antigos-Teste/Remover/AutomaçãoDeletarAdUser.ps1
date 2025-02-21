import-Csv -Path .\Desktop\list_form_remove.csv -Delimiter ';' -PipelineVariable User | ForEach-Object -Process {
    $Names = '{0}.{1}.{2}' -f $User.GivenName, $User.MiddleInitial, $User.Surname
    $AccountNames = ([Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Names))).ToLower()
    Get-ADUser -Filter 'Name -like ${AccountNames}' | Remove-ADUser
}
