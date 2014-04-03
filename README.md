##DB Change Management With Liquibase

This servers as an example liquibase set up following the liquibases best practices as outlined on the [liquibase website](http://www.liquibase.org/bestpractices.html).

###SqlFire Example
You will find the required jar files in the lib folder of the liquibase version that has been packaged. 

* sqlfireclient.jar
* liquibase-sqlfire-3.0.0.jar (sqlfire extensions for liquibase)

The example loads the example schema that was shipped with verion 1.0 of SqlFire and was used in thier documentation. (Airline, Cities, Flights, etc).

The schema generation uses the functionality add in liquibase 3.0 to use annotated sql scripts. This allows the ability to use the extended keyword set required for sqlfire schemas (collocate, replicate, etc)

It also loads example reference data that was provided with the example sqlfire download.

It is important to note that due to the extended keyword set and changes to the information schema from Apache Derby to support distribution that currently database diff/generateChangelog is not supported.


###SqlServer Example


###PostgreSql Example
