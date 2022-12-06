#location of AD users file
$file = "C:\Users\Administrator\Documents\automatiseeritud skriptimine\adkasutajad.csv"
#import file content
$users = Import-Csv $file -Encoding Default -Delimiter ";"
#foreach user data row in file
$ErrorActionPreference = 'SilentlyContinue' # süsteemi teadete välja lülitamine
foreach ($user in $users){
    #username is firstname.lastname
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translate($username)
    #user principal name
    $upname = $username + "@sv-kool.local"
    #display name - eesnimi + perenimi
    $displayname = $user.FirstName + " " + $user.LastName
    New-ADUser -Name $username `
        -DisplayName $displayname `
        -GivenName $user.FirstName `        -Surname $user.LastName `
        -Department $user.Department `
        -Title $user.Role `
        -UserPrincipalName $upname `
        -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -force) -Enabled $true
    if(!$?){
        Get-ADUser $username | Out-Null
        if($?){
            Write-Output "Kasutaja $username juba eksisteerib"
        }
    }
    else {
        Write-Output "Loodi kasutaja $username"
    }
}

$ErrorActionPreference = 'Stop'

#function translit UTF-8 characters to LATIN
function Translate {
    #function uses parameter string to translate
    param(
        [string] $inputString
    )
    #define the characters which have to be translated
        $Translate = @{
        [char]'ä' = "a"
        [char]'ö' = "o"
        [char]'ü' = "u"
        [char]'õ' = "o"
        }
    #create translated output
    $outputString=""
    #transfer string to array of characters and by character
    foreach ($character in $inputCharacter = $inputString.ToCharArray())
    {
        #if the character exists in the list of characters for translating
        if ($Translate[$character] -cne $Null ){
            #add to output translated character
        } else {
            #otherwise add the initial character
            $outputString += $character
        }
    }
    Write-Output $outputString
}