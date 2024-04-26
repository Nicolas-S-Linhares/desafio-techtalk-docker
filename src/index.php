<?php
// Prints 'Hello, world!" to the screen.
echo 'Hello, world!';

$servername = getenv('DB_HOST');
$dbname = getenv('DB_NAME');
$username = getenv('DB_USER');
$password = getenv('DB_PASS');

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Increase the count and get the updated count
$sql = "UPDATE visitors SET counter = counter + 1";
if ($conn->query($sql) === TRUE) {
    $sql = "SELECT counter FROM visitors";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Output data of each row
        while($row = $result->fetch_assoc()) {
            echo '<br>Visitor count: ' . $row["counter"];
        }
    } else {
        echo "No results";
    }
} else {
  echo "Error updating record: " . $conn->error;
}

$conn->close();
?>