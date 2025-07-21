package com.example;

import java.io.*;
import java.util.*;

public class App {
    public static void main(String[] args) throws Exception {
        // Vulnerable: Hardcoded secret and unsafe file read
        String secret = "hardcoded-password";
        System.out.println("Secret: " + secret);

        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter filename: ");
        String filename = scanner.nextLine();

        File file = new File(filename);
        if (!file.exists()) {
            System.out.println("File does not exist. Exiting.");
            return;
        }

        BufferedReader reader = new BufferedReader(new FileReader(file));
        System.out.println("File contents: " + reader.readLine());
        reader.close();
    }
}