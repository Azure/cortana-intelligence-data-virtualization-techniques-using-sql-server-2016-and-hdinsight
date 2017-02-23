{
	"nbformat_minor": 1,
	"cells": [{
		"execution_count": null,
		"cell_type": "code",
		"source": "import sqlContext.implicits._\nimport java.util.Properties",
		"outputs": [],
		"metadata": {
			"collapsed": false
		}
	}, {
		"execution_count": null,
		"cell_type": "code",
		"source": "val server = \"$AZURE_SQL_SERVER\"\nval user = \"$ADMIN_USERNAME\"\nval password = \"$ADMIN_PASSWORD\"\nval database = \"$AZURE_SQL_DB\"\nval url = s\"jdbc:sqlserver://$server.database.windows.net:1433;database=$database;user=$user;password=$password\"",
		"outputs": [],
		"metadata": {
			"collapsed": false
		}
	}, {
		"execution_count": null,
		"cell_type": "code",
		"source": "val historicalSales = sqlContext.read.jdbc(url, \"SalesFromPastYears\", new Properties())\nhistoricalSales.registerTempTable(\"Historical\")",
		"outputs": [],
		"metadata": {
			"collapsed": false
		}
	}, {
		"execution_count": null,
		"cell_type": "code",
		"source": "val products = sqlContext.read.json(\"wasbs://edw-data-virtualization@bostondata.blob.core.windows.net/DimProduct.json\")\nproducts.registerTempTable(\"Products\")",
		"outputs": [],
		"metadata": {
			"collapsed": false
		}
	}, {
		"execution_count": null,
		"cell_type": "code",
		"source": "val joined = sqlContext.sql(\"SELECT h.*, p.EnglishProductName AS ProductName FROM Historical h INNER JOIN Products p ON h.ProductKey = p.ProductKey\")\njoined.show",
		"outputs": [],
		"metadata": {
			"collapsed": false
		}
	}],
	"nbformat": 4,
	"metadata": {
		"kernelspec": {
			"display_name": "Spark",
			"name": "sparkkernel",
			"language": ""
		},
		"language_info": {
			"mimetype": "text/x-scala",
			"pygments_lexer": "scala",
			"name": "scala",
			"codemirror_mode": "text/x-scala"
		}
	}
}