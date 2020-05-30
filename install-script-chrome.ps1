clear
 
# URL Parameter
$WebURL = "https://installationpackages.s3.ap-south-1.amazonaws.com/ChromeSetup.exe"
  
# Directory Parameter
$FileDirectory = "$($env:USERPROFILE)$("\downloads\")"
 
#Write-Output $FileDirectory
 
# If directory doesn't exist create the directory
if((Test-Path $FileDirectory) -eq 0)
    {
        mkdir $FileDirectory;
    }
 
# We assume the file you download is named what you want it to be on your computer
$FileName = [System.IO.Path]::GetFileName($WebURL)
 
# Concatenate the two values to prepare the download
$FullFilePath = "$($FileDirectory)$($FileName)"
 
#Write-Output $FullFilePath
 
function Get-FileDownload([String] $WebURL, [String] $FullFilePath)
{
        # Give a basic message to the user to let them know what we are doing
        Write-Output "Downloading '$WebURL' to '$FullFilePath'"
 
        $uri = New-Object "System.Uri" "$WebURL"
        $request = [System.Net.HttpWebRequest]::Create($uri)
        $request.set_Timeout(30000) #15 second timeout
        $response = $request.GetResponse()
        $totalLength = [System.Math]::Floor($response.get_ContentLength()/1024)
        $responseStream = $response.GetResponseStream()
        $targetStream = New-Object -TypeName System.IO.FileStream -ArgumentList $FullFilePath, Create
        $buffer = new-object byte[] 10KB
        $count = $responseStream.Read($buffer,0,$buffer.length)
        $downloadedBytes = $count
        while ($count -gt 0)
            {
                [System.Console]::Write("`r`nDownloaded {0}K of {1}K", [System.Math]::Floor($downloadedBytes/1024), $totalLength)
                $targetStream.Write($buffer, 0, $count)
                $count = $responseStream.Read($buffer,0,$buffer.length)
                $downloadedBytes = $downloadedBytes + $count
            }
         
        $targetStream.Flush()
        $targetStream.Close()
        $targetStream.Dispose()
        $responseStream.Dispose()
         
        # Give a basic message to the user to let them know we are done
        Write-Output "`r`nDownload complete"
    }
 
 
Get-FileDownload $WebURL $FullFilePath
 
cd $FileDirectory

Start-Process -FilePath $FullFilePath -Args "/silent /install" -Verb RunAs -Wait
