# ALICE


## What is ALICE?


ALICE stands for *Adaptive Learning for Interdisciplinary Collaborative Environments*. ALICE is an information system that designs a learning environment for students based on their interaction with the system.


ALICE implements an educational philosophy that favors connectedness across subject areas, and acquisition of broad competencies that deploy multiple skills to solve real-world problems.


## Components of ALICE


ALICE was conceived in 1996, designed in 1999 using ASP and a draft of the XML standard adopted by the Word Wide Web Consortium, and finally implemented very close to its current state in 2003 in VB.NET. It is an ancient system by Web standards. However, it is still a valid development approach... and blazingly fast.  

To install ALICE: 

1. Clone the repository and map it with a .NET-capable Web server (e.g. IIS, Apache+Mono, etc.). If you are not familiar with this step, a search engine or a generative AI agent can guide you. You need to create the folders `uploads`, `artifex_uploads`, `docs`. There are other folders, as documented in .gitignore.


2. Restore the database. The backup contains the user ALICE. You can delete it, and assign access permissions to other users in your database server.


3. You need to create two server variables: (i) An environmental variable that will store the database connection string; you can name this variable anything you want, but by default this is defined in the file `Web.config`, in the appSetting `DB_CONN_STRING`. By default this variable is called `ALICE_CONN_STRING`. It might look something like: *data source=.; Initial Catalog=ALICE;User ID=ALICE;Password=[your password]*. (ii) You need the environmental variable `OPENAI_API_KEY` to connect to the OpenAI API.


The system has the following components:


**SQL Server Database:** The file ALICE.BAK is located at the root. Restore it with SQL Server. 


**Administrator's Interface:**  Folder Admin. It is recommended that you use HTTPS and Basic Authentication for this folder. You really don't want anyone trying to hit these pages, although they are reasonably secure.


**Application Classes:**  Here are some classes needed for the proper functioning of the application


**Javascript Libraries:**  The folder 'Common' contains the master JavaScript file, called ALICE.js. The site also uses three standard libraries: Vis, Showdown and KaTeX. You could link those libraries instead of keeping the code, but two decades of developing this system have shown that you really want to secure all the source code you need, instead of relying on libraries of unknown permanence.  


**Images:** The system has a number of images in these folders. Alter with care.


**User Pages:** Users interact with the system using exclusively the pages in this folder


**XSL Templates:**  The system extracts XML from the relational database, and then applies an XSL template to transform XML to HTML for every page. It is cumbersome at first, but very powerful and reusable once you master it.


## Regarding the use of XML


It was the 90s. The Web was a Wild West. Trying to pick a technology for developing a project was a very difficult choice because it was not clear at all what would remain. This was the age of Macromedia, ColdFusion, Netscape, Java Applets, Flash... and a long et cetera of long dead technologies.


However, in February, 1998, version 1 of the XML, or Extensible Markup Language, was released by the W3C consortium. By 1999, libraries to transform XML into HTML (or any other markup schema) were ubiquitous, and, most important, compatible  among themselves. This was the break needed to design something that could live for decades.  


XML maintains its status as a highly stable technology. Since its inception in the late 1990s, XML has established itself as a cornerstone for data interchange across diverse systems, particularly in environments that require rigorous data structuring and validation. Its stability stems from its widespread adoption and the strong support it receives from numerous applications, programming languages, and frameworks.


XML's design focuses on simplicity, generality, and usability across the Internet. This design philosophy contributes to its enduring stability and relevance. Additionally, the technology is supported by a comprehensive specification maintained by the World Wide Web Consortium (W3C), which ensures its continued suitability and adaptability to new computing environments and requirements.


While newer technologies like JSON have become popular for web applications due to their lighter weight and ease of use with JavaScript, XML remains indispensable in many enterprise, governmental, and scientific contexts where document validity and precise data structuring are critical. This includes industries like banking, healthcare, and telecommunications, which rely on XML for its ability to robustly handle long-term data storage and complex data structures.


Overall, XML's stability is reinforced by its extensive ecosystem of tools and its ability to integrate with legacy systems, ensuring it remains a reliable choice for many data interchange needs for many decades (centuries?) to come.

## Funders of ALICE

ALICE is powered by the [Literatronica](https://en.wikipedia.org/wiki/Literatronica) engine designed by [Prof. Juan B. Gutiérrez](https://biomathematicus.me/).  The development of ALICE has been funded across three continents by: 

**USA:** National Institutes of Health - National Institute of General Medical Sciences (NIGMS). Award #[1R25GM151182](https://reporter.nih.gov/project-details/10723223), 2023-2028.

**USA:** National Science Foundation (NSF). Award #[1645325](https://nsf.gov/awardsearch/showAward?AWD_ID=1645325&HistoricalAwards=false), 2016-2019.

**Spain:** Ministerio de Industria y Turismo de España (Spanish Ministry of Industry and Tourism). Sub-award from contract TSI-070300-2008-67, 2008-2009.

**Colombia:** Instituto Distrital de Cultura y Turismo de Bogotá (Institute of Culture and Tourism of the City of Bogota). Award #IDCT-410/1998.

**Colombia:** Instituto Distrital de Cultura y Turismo de Bogotá (Institute of Culture and Tourism of the City of Bogota). Award #IDCT-514/1997.

**Colombia:** Colcultura - Instituto Colombiano de Cultura, now the Ministerio Colombiano de Cultura (Colombian Institute of Culture, now the Ministry of Culture), Award # COLCULTURA-SECAB 014/1996.

