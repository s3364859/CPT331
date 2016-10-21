# EventGuardian
## Spatio News Stands
CPT331 SP3 2016 RMIT University collborative project.

## Project Descriptions

### CPT331.Core
Contains shared types, such as extensions and the object model.

### CPT331.Data
Contains repository types.

### CPT331.Data.Migration
Console app used to create and populate the database.

### CPT331.Data.Parsers
Contains parser types used to convert various file-based data sources into a common object model.

### CPT331.iOS
iOS app implementation.

### CPT331.Web
ASP.NET MVC website used to administer the database.

### CPT331.Web.Tests
Contains tests.

### CPT331.WebAPI
ASP.NET Web API website used to serve data to a client.

### CPT331.WebAPI.Parsers
Contains parser types used to convert various web data sources into a common object model.

### CPT331.WebAPI.Tests
Contains tests.

## GIT Setup
The very first step is to clone this repo. From gitbash:
1. Get git installed on your machine. It is recommended that you get familiar working with git bash, it is popular and doesn’t shield you from what git is actually doing (important)
2. Set up a directory on your machine for development work – e.g, 'C:\Development' is suitably creative
3. Open git bash, and CD into your development directory
4. Clone this repo: https://github.com/s3364859/CPT331.git
5. Take a fork of this repo from here: https://github.com/s3364859/CPT331
6. In git bash: git remote rename origin upstream
7. Note the URL of your fork’s repo – it should be something like this: https://github.com/YOURUSERNAME/CPT331.git
8. In git bash: git remote add origin: https://github.com/YOURUSERNAME/CPT331.git
9. Finally, run git remote -v, and you should see something like this:

origin      https://github.com/YOURUSERNAME/CPT331.git (fetch)
origin      https://github.com/YOURUSERNAME /CPT331.git (push)
upstream    https://github.com/s3364859/CPT331.git (fetch)
upstream    https://github.com/s3364859/CPT331.git (push)

10. All done, bam!

## Local Website Projects Setup
1. Make sure IIS is installed
2. Make sure you’ve cloned the git repo and have the latest code
3. Open the file C:\Windows\System32\drivers\etc\hosts
 - You may need to take ownership of this file as Windows typically doesn’t want you fiddling about in there
4. Add the following entries:
 - 127.0.0.1              cpt331.api.internal
 - 127.0.0.1              cpt331.web.internal
5. Save the file
 - You may need to change write permissions for this file, but eventually you will be able to save it
6. Verify these changes have worked:
 - Open a command prompt and ping each host – you should see a response from 127.0.0.1
7. Open up IIS Manager
8. Right click on Sites -> Add Website
 - Site name: CPT331 Web
 - Application pool: .NET v4.5
 - Physical path: {WhereverTheRepoIs}\CPT331\CPT331.Web
 - Host name: cpt331.web.internal
 - Click OK
9. Right click on Sites -> Add Website
 - Site name: CPT331 Web API
 - Application pool: .NET v4.5
 - Physical path: {WhereverTheRepoIs}\CPT331\CPT331. WebAPI
 - Host name: cpt331.api.internal
 - Click OK
10. The two sites are now setup
11. Verify your sites are working:
 - http://cpt331.api.internal/swagger/ - you should see a page with a green header
 - http://cpt331.web.internal/ - you should see a page about ASP.NET

## Database Setup
1. Make sure SQL Server is installed
 - 2016 is preferred, 2014 will cut the mustard however
2. Make sure you’ve cloned the git repo and have the latest code
3. Build the project
4. Ensure that you have located and extracted all the data sources to the following location:
 - XML: "C:\Downloads\Crime Data\XML Data Sources"
 - KML: "C:\Downloads\Crime Data\KML Data Sources"
 - The directory here should match the MigrationDataSourceDirectory value in the configuration settings of the migrator app
4. Open a command prompt, and change directory to the migration project directory
 - The path will be something like \CPT331\CPT331.Data.Migration\bin\Debug
5. Run the following command:
 - CPT331.Data.Migration -d True -x ALL -k ALL
 - The -d switch drops and recreates the database
 - The -x switch imports the data inside all the XML documents
 - The -k switch imports the data inside all the KML documents
6. Go and make a sanger - the import will take a while (15-30 minutes)
