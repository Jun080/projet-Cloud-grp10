<html><body>
<form method="POST">
<input type="text" id="username" name="username" placeholder="Username">
<input type="text" id="urlSite" name="urlSite" placeholder="Url Site">
<input type="submit" name="creation_compte" value="Créer mon compte">
</form>

<?php 
/* creation account */
if (isset($_POST['creation_compte'])) {
    $username = $_POST['username'];
    $url = $_POST['urlSite'];
    echo shell_exec("./demo.sh $username $url");
}
?>

<!-- storage -->
<form method="POST">
<input type="text" id="user_size" name="user_size" placeholder="User">
<input type="submit" name="show_size" value="Storage">
</form>

<?php
if (isset($_POST['show_size'])) {
	$user_size = $_POST['user_size'];
	$AccountSize = shell_exec("du -sh /home/$user_size | awk '{print $1}'");
	echo "<pre>Espace consommé par $user_size : $AccountSize</pre>";
	$DBSize = shell_exec("sudo du -sh /var/lib/mysql/$user_size | awk '{print $1}'");
	echo "<pre>Espace consommé par la base de données : $DBSize</pre>";
}
?>
<br>

<form method="POST">
<input type="text" id="user" name="user" placeholder="Username">
<input type="text" id="pwd" name="pwd" placeholder="Password">
<input type="text" id="newpwd" name="newpwd" placeholder="New Password">
<input type="submit" name="change_password" value="Change Password">
</form>

<?php
/* change password */
if (isset($_POST['change_password'])) {
        $user = $_POST['user'];
        $pwd = $_POST['pwd'];
        $newpwd = $_POST['newpwd'];
        echo shell_exec("./newpwd.sh $user $pwd $newpwd");
	/*echo exec("./newpwd.sh $user $pwd $newpwd", $output, $return_var);
	echo "$return_var";*/
}
?>
<br>

<form method="POST">
<input type="text" name="user_backup" placeholder="Username">
<input type="submit" name="backup" value="backup">
</form>

<?php
/* backup */
if (isset($_POST['backup'])) {
        $user_backup = $_POST['user_backup'];
	echo shell_exec("./backup.sh $user_backup");
}
?>
<br>
</body>
</html>
