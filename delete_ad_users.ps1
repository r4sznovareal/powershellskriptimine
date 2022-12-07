$FirstName = Read-Host -Prompt "Please enter the user's firstname"
$LastName = Read-Host -Prompt "Please enter the user's lastname"


$username = $FirstName.ToLower() + "." + $LastName.ToLower()
$username = Translate($username)
$upname = $username + "@sv-kool.local"

if (Get-ADUser -F  {SamAccountName -eq $username}) {
    Remove-ADUser -Identity $username
    Write-Output "The user $username has been removed"
} else {
    Write-Output "The user $username does not exist"
}
#function translates UTF-8 characters to LATIN
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
        $outputString += $Translate[$character]
            #add to output translated character
        } else {
            #otherwise add the initial character
            $outputString += $character
        }
         }
            Write-Output $outputString
}