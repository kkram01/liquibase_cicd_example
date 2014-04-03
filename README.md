##DB Change Management With Liquibase

This serves as an example liquibase set up following the liquibase's best practices as outlined on the [liquibase website](http://www.liquibase.org/bestpractices.html).

###SqlFire Example
You will find the required jar files in the lib folder of the packaged version of liquibase. 

* sqlfireclient.jar
* liquibase-sqlfire-3.0.0.jar (sqlfire extensions for liquibase)

The example creates the example schema that was shipped with verion 1.0 of SqlFire and was used in thier documentation. (Airline, Cities, Flights, etc).

The schema generation uses the functionality added in liquibase 3.0 to use annotated sql scripts. This allows for the use of sqlfire's extended keyword set required for sqlfire schemas (collocate, replicate, etc).

It also loads reference data that was provided with the example sqlfire download.

It is important to note that due to the extended keyword set and changes to the information schema from Apache Derby to support sqlfire's distribution, liquibase funcitionality such as database diff/generateChangelog is not supported.


###SqlServer Example


###PostgreSql Example
