<?php

    function getPost($key) {
        if (isset($_POST[$key])) {
            return $_POST[$key];
        }
        return ''; 
    }
 
?>