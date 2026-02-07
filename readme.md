# duckmail-cli
### A simple bash script to manage your duckduckgo email forwarding functions.
***
### How to get the API key (Token):
simply visit the [duckduckgo website](https://duckduckgo.com/email/) and sign up for an account. it requires the Duckduckgo extension, you will get a notification page in case it's not installed. once you created the account simply open the inspect element and go to the network tab, then click on "Generate private Duck Adress". in the appeared sent requests click on the POST request, under "Request Headers" there is a key called "Authorization" which contains the key in the following manner "Bearer $key$". you can save the $key$ value, and add it using
```
duckmail --token $key$
```
<img width="1920" height="429" alt="image" src="https://github.com/user-attachments/assets/d3fa3c87-ec00-4999-baab-d89be1294080" />

***

after that you no longer need the extension or browser, you can do everything with the tool. use 
```
duckmail --help
```
to see the commands available.

## Dependencies
`Curl` to do the Api calls.
