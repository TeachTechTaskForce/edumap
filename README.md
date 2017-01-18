# EduMap
[The app is up on Heroku](https://edumap3.herokuapp.com)

## Minimal commands to get the app running (if you have things set up)

[More system-specific setup information is on our wiki](https://github.com/TeachTechTaskForce/edumap/wiki).

```sh
git clone https://github.com/andyras/edumap.git
cd edumap/edumap
gem install bundler
bundle install
rake db:create  # you may have to prepend `bundle exec` to get this to work.
rake db:migrate
rake db:seed
rails s
```
View the app at <http://localhost:3000>

### Linux
Linux users will have to install and configure postgresSQL before running the above commands.
- [Arch](https://wiki.archlinux.org/index.php/PostgreSQL#Installing_PostgreSQL)
- [Ubuntu](https://help.ubuntu.com/lts/serverguide/postgresql.html#postgresql-installation)
- [Debian](https://wiki.debian.org/PostgreSql#Installation)

## How to contribute

### Everyone: play with the site!
If you see anything that you think could be improved on the [site](edumap3.herokuapp.com), let us know by submitting an [issue](https://github.com/TeachTechTaskForce/edumap/issues) (make sure you have a github account first).

### Web developers: code!
There are usually a few frontend tweaks that we are working on; browse our [issues list](https://github.com/TeachTechTaskForce/edumap/issues) to see how you can contribute.

### Data scientists / data entry experts: add curriculum!
**Option 1**: manual data entry
[Our publicly editable curriculum status sheet](https://docs.google.com/spreadsheets/d/1jbdx7ImdbcGbpG2AB5V37Rdjj6ABXP5y4fkM0onpRzw/edit#gid=1308793623) has a 'template' tab; duplicate this tab, give it an appropriate name, and enter information from a particular curriculum.

**Option 2**: scrape to .csv
Some websites are organized enough (and large enough) to merit scraping the information programatically. If you have the expertise, you're welcome to scrape sites that are out there and output to .csv.

**Both options**: Further down in this README, there is a specification of what we are looking for as far as data about curriculum options.

## Curricula

### List and status
[View curriculum status here](https://docs.google.com/spreadsheets/d/1jbdx7ImdbcGbpG2AB5V37Rdjj6ABXP5y4fkM0onpRzw/edit#gid=1308793623)
- [CS Unplugged](http://csunplugged.org)
  - scraped: age, lesson names
- [Google Computational Thinking](https://www.google.com/edu/resources/programs/exploring-computational-thinking/index.html#!ct-materials) - Pete is working on this during the week of 2/2
- [ScratchEd Creative Computing](http://scratched.gse.harvard.edu/guide/download.html)
- [Code.org](https://studio.code.org)
  - standards
  - (lesson plans require login or direct link)
- [Computational Thinking (Northwestern)](http://ct-stem.northwestern.edu/lesson-plans/)
- [CS First](http://www.cs-first.com/)
- Find more resources here...  http://cs4hs.com/resources/cscs-results.html#q=
- Possibility: [TED Ed](http://ed.ted.com/)

### Desiderata for each curriculum
In general curricula are broken up into lessons; that is the quantum of curriculum we are working with. Most information will be one-to-one (e.g. age range), and some will be many-to-one (many standards codes map onto one lesson).

#### Scraping Essentials
- Identifier for each lesson
  - The unique identifier for each lesson is the name of the curriculum plus a code for that lesson.
  - two strings with no whitespace, e.g. `Code.org,1.1`
- URL for lesson
  - should be publicly visible
  - string, e.g. `"https://code.org/curriculum/course1/1/Teacher"`
- Age (or grade) range for each lesson
  - string, e.g. `"Ages 8-10"`, `"Grade 4"`
- Short description for each lesson
  - string, e.g. `"Happy Maps"`
- Time for lesson
  - string, e.g. `"1 class period"`, `"45 minutes"`
  - If you have to guess, add `"est."` before the time, e.g. `"est. 1 class period"`
- Platform/OS or materials
  - string, e.g. `"Web"`, `"iOS, Android"`,  `"pencil, paper, SPAM"`
- Plugged vs. Unplugged
  - string, either `"Plugged"` or `"Unplugged"`

#### Scraping Nice-to-haves
- Topic area
  - string, e.g. `"Loops"`, `"Internet security"`

### To Deploy to Heroku
From the root directory of the app:
`git subtree push --prefix edumap heroku master`

## Standards so far
### [International Standards](https://docs.google.com/spreadsheets/d/1SE7hGK5CkOlAf6oEnqk0DPr8OOSdyGZmRnROhr0XHys/edit#gid=218360034)
- [CSTA](http://csta.acm.org/Curriculum/sub/CurrFiles/CSTA_K-12_CSS.pdf)
- [ISTE](http://www.iste.org/standards/iste-standards/standards-for-students)
- [NGSS](http://www.nextgenscience.org/search-performance-expectations)
- [Common Core ELA](http://www.corestandards.org/wp-content/uploads/ELA_Standards1.pdf)
- [Common Core ELA](http://www.corestandards.org/ELA-Literacy/)
- [Common Core Math](http://www.corestandards.org/wp-content/uploads/Math_Standards1.pdf)
- [Common Core Math](http://www.corestandards.org/Math/)
- [Common Core csv. file producer](http://www.ode.state.or.us/teachlearn/real/standards/)

### Desiderata for each standard
- Standard name
  - string, e.g. `"NGSS"`, `"CC Math"`
- Standard code
  - string, e.g. `"6.NS.8"`
- Description of student outcome
  - string, e.g. `"Solve real-world and mathematical problems by graphing points in all four quadrants of the coordinate plane. Include use of coordinates and absolute value to find distances between points with the same first coordinate or the same second coordinate."`

#### Scraping Essentials
- Identifier for each standard item
  - The unique identifier for a standard item comprises the name of the standard plus the specific code
  - two strings, no whitespace in the code portion, e.g. `"NGSS,HS-ETS1-1"`
- Description of the standard item
  - string, e.g. `"Analyze a major global challenge to specify qualitative and quantitative criteria and constraints for solutions"`

#### Scraping Nice-to-haves
- Hierarchy
  - Each standard has a hierarchy, e.g. the Common Core Math has Standards > Clusters > Domains
  - This would be an .md file giving a brief breakdown of how the standard is structured (useful if we decide to someday have filtering by intermediate areas of each standards hierarchy)

## Mappings
A mapping is a set of connections between a lesson and standards codes.

### CSV Format
- The format is the lesson identifier followed by the standard item identifier
  - e.g. `"Code.org,1.1,ISTE,1.c"`
