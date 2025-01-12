Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 
$buttonClicked = $false 
$channels = @() 
for ($i = 1; $true; $i++) { 
    $varName = "channel$i" 
    $value = [Environment]::GetEnvironmentVariable($varName) 
    if ($null -eq $value) { break } 
    $channels += $value 
} 
$form = New-Object System.Windows.Forms.Form 
$form.Text = "NSOVVG" 
$form.Width = 800 
$form.Height = 300 
$form.StartPosition = 'CenterScreen' 
$listBox = New-Object System.Windows.Forms.ListBox 
$listBox.Location = New-Object System.Drawing.Point(10, 10) 
$listBox.Size = New-Object System.Drawing.Size(700, 200) 
$listBox.SelectionMode = 'One' 
$listBox.Items.AddRange($channels) 
$form.Controls.Add($listBox) 
$btnUp = New-Object System.Windows.Forms.Button 
$btnUp.Text = "Up" 
$btnUp.Location = New-Object System.Drawing.Point(710, 30) 
$btnUp.Add_Click({ 
    $selectedIndex = $listBox.SelectedIndex 
    if ($selectedIndex -gt 0) { 
        $temp = $listBox.Items[$selectedIndex] 
        $listBox.Items[$selectedIndex] = $listBox.Items[$selectedIndex - 1] 
        $listBox.Items[$selectedIndex - 1] = $temp 
        $listBox.SelectedIndex = $selectedIndex - 1 
    } 
}) 
$form.Controls.Add($btnUp) 
$btnDown = New-Object System.Windows.Forms.Button 
$btnDown.Text = "Down" 
$btnDown.Location = New-Object System.Drawing.Point(710, 70) 
$btnDown.Add_Click({ 
    $selectedIndex = $listBox.SelectedIndex 
    if ($selectedIndex -lt $listBox.Items.Count - 1) { 
        $temp = $listBox.Items[$selectedIndex] 
        $listBox.Items[$selectedIndex] = $listBox.Items[$selectedIndex + 1] 
        $listBox.Items[$selectedIndex + 1] = $temp 
        $listBox.SelectedIndex = $selectedIndex + 1 
    } 
}) 
$form.Controls.Add($btnDown) 
$btnOK = New-Object System.Windows.Forms.Button 
$btnOK.Text = "OK" 
$btnOK.Location = New-Object System.Drawing.Point(100, 220) 
$btnOK.Add_Click({ 
    $newOrder = $listBox.Items 
	 $buttonClicked = $true 
foreach ($channel in $newOrder) { 
    $index = $channels.IndexOf($channel) 
    Write-Host ($index + 1) 
} 
    $form.Close() 
}) 
$form.Controls.Add($btnOK) 
$btnCancel = New-Object System.Windows.Forms.Button 
$btnCancel.Text = "Cancel" 
$btnCancel.Location = New-Object System.Drawing.Point(200, 220) 
$btnCancel.Add_Click({ 
	 $buttonClicked = $true 
    Write-Host "None" 
    $form.Close() 
}) 
$form.Controls.Add($btnCancel) 
$form.Add_Shown({ $form.Activate() }) 
[void]$form.ShowDialog() 
$form.Add_FormClosing({ 
    if (-not $buttonClicked) { 
        Write-Host "None" 
    } 
}) 
