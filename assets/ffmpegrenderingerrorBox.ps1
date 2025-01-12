Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 
$filePath = $args[0] 
$contactText = if (Test-Path $filePath) { 
    $content = Get-Content $filePath -Raw 
    if (-not [string]::IsNullOrWhiteSpace($content)) { 
        $content 
    } else { 
        "None" 
    } 
} else { 
    "None" 
} 
$form = New-Object System.Windows.Forms.Form 
$form.Text = "NSOVVG" 
$form.Width = 450 
$form.Height = 600 
$form.StartPosition = 'CenterScreen' 
$errorLabel = New-Object System.Windows.Forms.Label 
$errorLabel.Text = $args[1] + 
                   "`nTo send this error to the developer, click [Save]`n" + 
                   "and send the log file to one of the following contacts:" 
$errorLabel.Location = New-Object System.Drawing.Point(10, 10) 
$errorLabel.Size = New-Object System.Drawing.Size(420, 60) 
$form.Controls.Add($errorLabel) 
$contactBox = New-Object System.Windows.Forms.TextBox 
$contactBox.Multiline = $true 
$contactBox.Text = "Email: heeminwelcome1@gmail.com`r`nDiscord: _yumetaro_" 
$contactBox.Location = New-Object System.Drawing.Point(10, 80) 
$contactBox.Size = New-Object System.Drawing.Size(410, 30) 
$contactBox.ReadOnly = $true 
$form.Controls.Add($contactBox) 
$Banner = New-Object System.Windows.Forms.Label 
$Banner.Text = "Error log:" 
$Banner.Location = New-Object System.Drawing.Point(10, 115) 
$Banner.Size = New-Object System.Drawing.Size(420, 15) 
$form.Controls.Add($Banner) 
$ErrorBox = New-Object System.Windows.Forms.TextBox 
$ErrorBox.Multiline = $true 
$ErrorBox.Text = $contactText 
$ErrorBox.Location = New-Object System.Drawing.Point(10, 130) 
$ErrorBox.Size = New-Object System.Drawing.Size(410, 350) 
$ErrorBox.ReadOnly = $true 
$form.Controls.Add($ErrorBox) 
$saveButton = New-Object System.Windows.Forms.Button 
$saveButton.Text = "Save" 
$saveButton.Location = New-Object System.Drawing.Point(80, 530) 
$saveButton.Add_Click({ 
    Write-Host "YES" 
	 $buttonClicked = $true 
    $form.Close() 
}) 
$form.Controls.Add($saveButton) 
$cancelButton = New-Object System.Windows.Forms.Button 
$cancelButton.Text = "Cancel" 
$cancelButton.Location = New-Object System.Drawing.Point(240, 530) 
$cancelButton.Add_Click({ 
    Write-Host "None" 
	 $buttonClicked = $true 
    $form.Close() 
}) 
$form.Controls.Add($cancelButton) 
$form.Add_FormClosing({ 
    if (-not $buttonClicked) { 
        Write-Host "None" 
    } 
}) 
$buttonClicked = $false 
$form.Add_Shown({ $form.Activate() }) 
[void]$form.ShowDialog() 
