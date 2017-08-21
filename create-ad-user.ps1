Import-Module ActiveDirectory
$server = 'dc1.internal.example.com'
$domain = 'DC=internal,DC=example,DC=com'
$company = 'company'
$continent = 'europe'
$country = 'germany'
$city = 'berlin'
$password = ConvertTo-SecureString -String 'P@ssword!'
do {
    Write-Output 'Please provide the following information for the new user:'
    $firstname = Read-Host -Prompt 'First name'
    $lastname = Read-Host -Prompt 'Last name'
    $department = Read-Host -Prompt 'Department'

    $username = $firstname.ToLower().Substring(0,1) + $lastname.ToLower()
    $path = "OU=$department,OU=$city,OU=$country,OU=$continent,OU=users,OU=$company,$domain"
    $identity = "CN=$firstname $lastname,$path"

    Write-Output "Creating user $firstname $lastname as $username in $department, located in $path."
    $confirm = Read-Host -Prompt "Continue? (y/n)"

    if($confirm -eq 'y') {
        New-ADUser -DisplayName:"$firstname $lastname" -GivenName:"$firstname" -Name:"$firstname $lastname" -Path:$path -SamAccountName:$username -Server:$server -Surname:"$lastname" -Type:'user' -UserPrincipalName:"$username@$company"
        Set-ADAccountPassword -Identity:$identity -NewPassword:$password -Reset:$true -Server:$server
        Enable-ADAccount -Identity:$identity -Server:$server
        Add-ADPrincipalGroupMembership -Identity:$identity -MemberOf:"CN=$department,OU=groups,OU=$company,$domain" -Server:$server
        Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:$identity -PasswordNeverExpires:$false -Server:$server -UseDESKeyOnly:$false
        Set-ADUser -ChangePasswordAtLogon:$true -Identity:$identity -Server:$server -SmartcardLogonRequired:$false
    }
    $continue = Read-Host -Prompt 'Would you like to add another user? (y/n)'
} while ($continue -eq 'y')