CREATE TABLE $(schema).AdventureWorksDWBuildVersion(
	DBVersion nvarchar(50) NOT NULL,
	VersionDate datetime NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(DBVersion));

CREATE TABLE $(schema).DatabaseLog(
	DatabaseLogID int NOT NULL,
	PostTime datetime NOT NULL,
	DatabaseUser nvarchar(128) NOT NULL,
	Event nvarchar(128) NOT NULL,
	[Schema] nvarchar(128),
	[Object] nvarchar(128),
	TSQL nvarchar(4000) NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(DatabaseLogID));

CREATE TABLE $(schema).DimAccount(
	AccountKey int NOT NULL,
	ParentAccountKey int,
	AccountCodeAlternateKey int,
	ParentAccountCodeAlternateKey int,
	AccountDescription nvarchar(50),
	AccountType nvarchar(50),
	Operator nvarchar(50),
	CustomMembers nvarchar(300),
	ValueType nvarchar(50),
	CustomMemberOptions nvarchar(200))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(AccountKey));

CREATE TABLE $(schema).DimCurrency(
	CurrencyKey int NOT NULL,
	CurrencyAlternateKey nchar(3) NOT NULL, 
	CurrencyName nvarchar(50) NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(CurrencyKey));

CREATE TABLE $(schema).DimCustomer(
	CustomerKey int NOT NULL,
	GeographyKey int,
	CustomerAlternateKey nvarchar(15) NOT NULL, 
	Title nvarchar(8),
	FirstName nvarchar(50),
	MiddleName nvarchar(50),
	LastName nvarchar(50),
	NameStyle bit,
	BirthDate date,
	MaritalStatus nchar(1),
	Suffix nvarchar(10),
	Gender nvarchar(1),
	EmailAddress nvarchar(50),
	YearlyIncome money,
	TotalChildren tinyint,
	NumberChildrenAtHome tinyint,
	EnglishEducation nvarchar(40),
	SpanishEducation nvarchar(40),
	FrenchEducation nvarchar(40),
	EnglishOccupation nvarchar(100),
	SpanishOccupation nvarchar(100),
	FrenchOccupation nvarchar(100),
	HouseOwnerFlag nchar(1),
	NumberCarsOwned tinyint,
	AddressLine1 nvarchar(120),
	AddressLine2 nvarchar(120),
	Phone nvarchar(20),
	DateFirstPurchase date,
	CommuteDistance nvarchar(15))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(CustomerKey));

CREATE TABLE $(schema).DimDate(
	DateKey int NOT NULL,
	FullDateAlternateKey date NOT NULL, 
	DayNumberOfWeek tinyint NOT NULL,
	EnglishDayNameOfWeek nvarchar(10) NOT NULL,
	SpanishDayNameOfWeek nvarchar(10) NOT NULL,
	FrenchDayNameOfWeek nvarchar(10) NOT NULL,
	DayNumberOfMonth tinyint NOT NULL,
	DayNumberOfYear smallint NOT NULL,
	WeekNumberOfYear tinyint NOT NULL,
	EnglishMonthName nvarchar(10) NOT NULL,
	SpanishMonthName nvarchar(10) NOT NULL,
	FrenchMonthName nvarchar(10) NOT NULL,
	MonthNumberOfYear tinyint NOT NULL,
	CalendarQuarter tinyint NOT NULL,
	CalendarYear smallint NOT NULL,
	CalendarSemester tinyint NOT NULL,
	FiscalQuarter tinyint NOT NULL,
	FiscalYear smallint NOT NULL,
	FiscalSemester tinyint NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(DateKey));

CREATE TABLE $(schema).DimDepartmentGroup(
	DepartmentGroupKey int NOT NULL,
	ParentDepartmentGroupKey int,
	DepartmentGroupName nvarchar(50))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(DepartmentGroupKey));

CREATE TABLE $(schema).DimEmployee(
	EmployeeKey int NOT NULL,
	ParentEmployeeKey int,
	EmployeeNationalIDAlternateKey nvarchar(15), 
	ParentEmployeeNationalIDAlternateKey nvarchar(15), 
	SalesTerritoryKey int,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	MiddleName nvarchar(50),
	NameStyle bit NOT NULL,
	Title nvarchar(50),
	HireDate date,
	BirthDate date,
	LoginID nvarchar(256),
	EmailAddress nvarchar(50),
	Phone nvarchar(25),
	MaritalStatus nchar(1),
	EmergencyContactName nvarchar(50),
	EmergencyContactPhone nvarchar(25),
	SalariedFlag bit,
	Gender nchar(1),
	PayFrequency tinyint,
	BaseRate money,
	VacationHours smallint,
	SickLeaveHours smallint,
	CurrentFlag bit NOT NULL,
	SalesPersonFlag bit NOT NULL,
	DepartmentName nvarchar(50),
	StartDate date,
	EndDate date,
	Status nvarchar(50)) 
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(EmployeeKey));

CREATE TABLE $(schema).DimGeography(
	GeographyKey int NOT NULL,
	City nvarchar(30),
	StateProvinceCode nvarchar(3),
	StateProvinceName nvarchar(50),
	CountryRegionCode nvarchar(3),
	EnglishCountryRegionName nvarchar(50),
	SpanishCountryRegionName nvarchar(50),
	FrenchCountryRegionName nvarchar(50),
	PostalCode nvarchar(15),
	SalesTerritoryKey int)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(GeographyKey));

CREATE TABLE $(schema).DimOrganization(
	OrganizationKey int NOT NULL,
	ParentOrganizationKey int,
	PercentageOfOwnership nvarchar(16),
	OrganizationName nvarchar(50),
	CurrencyKey int)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(OrganizationKey));

CREATE TABLE $(schema).DimProduct(
	ProductKey int NOT NULL,
	ProductAlternateKey nvarchar(25),		
	ProductSubcategoryKey int,
	WeightUnitMeasureCode nchar(3),
	SizeUnitMeasureCode nchar(3),
	EnglishProductName nvarchar(50) NOT NULL,
	SpanishProductName nvarchar(50),
	FrenchProductName nvarchar(50),
	StandardCost money,
	FinishedGoodsFlag bit NOT NULL,
	Color nvarchar(15) NOT NULL,
	SafetyStockLevel smallint,
	ReorderPoint smallint,
	ListPrice money,
	[Size] nvarchar(50),
	SizeRange nvarchar(50),
	Weight float,
	DaysToManufacture integer,
	ProductLine nchar(2),
	DealerPrice money,
	[Class] nchar(2),
	Style nchar(2),
	ModelName nvarchar(50),
	EnglishDescription nvarchar(400),
	FrenchDescription nvarchar(400),
	ChineseDescription nvarchar(400),
	ArabicDescription nvarchar(400),
	HebrewDescription nvarchar(400),
	ThaiDescription nvarchar(400),
	GermanDescription nvarchar(400),
	JapaneseDescription nvarchar(400),
	TurkishDescription nvarchar(400),
	StartDate datetime,
	EndDate datetime,
	Status nvarchar(7))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ProductKey));

CREATE TABLE $(schema).DimProductCategory(
	ProductCategoryKey int NOT NULL,
	ProductCategoryAlternateKey int,		
	EnglishProductCategoryName nvarchar(50) NOT NULL,
	SpanishProductCategoryName nvarchar(50) NOT NULL,
	FrenchProductCategoryName nvarchar(50) NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ProductCategoryKey));

CREATE TABLE $(schema).DimProductSubcategory(
	ProductSubcategoryKey int NOT NULL,
	ProductSubcategoryAlternateKey int, 
	EnglishProductSubcategoryName nvarchar(50) NOT NULL,
	SpanishProductSubcategoryName nvarchar(50) NOT NULL,
	FrenchProductSubcategoryName nvarchar(50) NOT NULL,
	ProductCategoryKey int)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ProductSubcategoryKey));

CREATE TABLE $(schema).DimPromotion(
	PromotionKey int NOT NULL,
	PromotionAlternateKey int,	
	EnglishPromotionName nvarchar(255),
	SpanishPromotionName nvarchar(255),
	FrenchPromotionName nvarchar(255),
	DiscountPct float,
	EnglishPromotionType nvarchar(50),
	SpanishPromotionType nvarchar(50),
	FrenchPromotionType nvarchar(50),
	EnglishPromotionCategory nvarchar(50),
	SpanishPromotionCategory nvarchar(50),
	FrenchPromotionCategory nvarchar(50),
	StartDate datetime NOT NULL,
	EndDate datetime,
	MinQty int,
	MaxQty int)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(PromotionKey));

CREATE TABLE $(schema).DimReseller(
	ResellerKey int NOT NULL,
	GeographyKey int,
	ResellerAlternateKey nvarchar(15), 
	Phone nvarchar(25),
	BusinessType varchar(20) NOT NULL,
	ResellerName nvarchar(50) NOT NULL,
	NumberEmployees int,
	OrderFrequency char(1),
	OrderMonth tinyint,
	FirstOrderYear int,
	LastOrderYear int,
	ProductLine nvarchar(50),
	AddressLine1 nvarchar(60),
	AddressLine2 nvarchar(60),
	AnnualSales money,
	BankName nvarchar(50),
	MinPaymentType tinyint,
	MinPaymentAmount money,
	AnnualRevenue money,
	YearOpened int)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ResellerKey));

CREATE TABLE $(schema).DimSalesReason(
	SalesReasonKey int NOT NULL,
	SalesReasonAlternateKey int NOT NULL,
	SalesReasonName nvarchar(50) NOT NULL,
	SalesReasonReasonType nvarchar(50) NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(SalesReasonKey));

CREATE TABLE $(schema).DimSalesTerritory(
	SalesTerritoryKey int NOT NULL,
	SalesTerritoryAlternateKey int,
	SalesTerritoryRegion nvarchar(50) NOT NULL,
	SalesTerritoryCountry nvarchar(50) NOT NULL,
	SalesTerritoryGroup nvarchar(50))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(SalesTerritoryKey));

CREATE TABLE $(schema).DimScenario(
	ScenarioKey int NOT NULL,
	ScenarioName nvarchar(50))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ScenarioKey));

CREATE TABLE $(schema).FactCallCenter(
	FactCallCenterID int NOT NULL,
	DateKey int NOT NULL,
	WageType nvarchar(15) NOT NULL,
	Shift nvarchar(20) NOT NULL,
	LevelOneOperators smallint NOT NULL,
	LevelTwoOperators smallint NOT NULL,
	TotalOperators smallint NOT NULL,
	Calls int NOT NULL,
	AutomaticResponses int NOT NULL,
	Orders int NOT NULL,
	IssuesRaised smallint NOT NULL,
	AverageTimePerIssue smallint NOT NULL,
	ServiceGrade float NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(FactCallCenterID));

CREATE TABLE $(schema).FactCurrencyRate(
	CurrencyKey int NOT NULL,
	DateKey int NOT NULL,
	AverageRate float NOT NULL,
	EndOfDayRate float NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(CurrencyKey));

CREATE TABLE $(schema).FactFinance(
	FinanceKey int NOT NULL,
	DateKey int NOT NULL,
	OrganizationKey int NOT NULL,
	DepartmentGroupKey int NOT NULL,
	ScenarioKey int NOT NULL,
	AccountKey int NOT NULL,
	Amount float NOT NULL) 
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(FinanceKey));

CREATE TABLE $(schema).FactInternetSales(
	ProductKey int NOT NULL,
	OrderDateKey int NOT NULL,
	DueDateKey int NOT NULL,
	ShipDateKey int NOT NULL,
	CustomerKey int NOT NULL,
	PromotionKey int NOT NULL,
	CurrencyKey int NOT NULL,
	SalesTerritoryKey int NOT NULL,
	SalesOrderNumber nvarchar(20) NOT NULL,
	SalesOrderLineNumber tinyint NOT NULL,
	RevisionNumber tinyint NOT NULL,
	OrderQuantity smallint NOT NULL,
	UnitPrice money NOT NULL,
	ExtendedAmount money NOT NULL,
	UnitPriceDiscountPct float NOT NULL,
	DiscountAmount float NOT NULL,
	ProductStandardCost money NOT NULL,
	TotalProductCost money NOT NULL,
	SalesAmount money NOT NULL,
	TaxAmt money NOT NULL,
	Freight money NOT NULL,
	CarrierTrackingNumber nvarchar(25),
	CustomerPONumber nvarchar(25))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ProductKey),
      PARTITION(OrderDateKey
      RANGE RIGHT FOR VALUES (
            20000101,20010101,20020101,20030101,20040101,20050101,20060101,20070101,20080101,20090101,
            20100101,20110101,20120101,20130101,20140101,20150101,20160101,20170101,20180101,20190101,
            20200101,20210101,20220101,20230101,20240101,20250101,20260101,20270101,20280101,20290101)));

CREATE TABLE $(schema).FactInternetSalesReason(
	SalesOrderNumber nvarchar(20) NOT NULL,
	SalesOrderLineNumber tinyint NOT NULL,
	SalesReasonKey int NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(SalesOrderNumber));

CREATE TABLE $(schema).ProspectiveBuyer(
	ProspectiveBuyerKey int NOT NULL,
	ProspectAlternateKey nvarchar(15),
	FirstName nvarchar(50),
	MiddleName nvarchar(50),
	LastName nvarchar(50),
	BirthDate datetime,
	MaritalStatus nchar(1),
	Gender nvarchar(1),
	EmailAddress nvarchar(50),
	YearlyIncome money,
	TotalChildren tinyint,
	NumberChildrenAtHome tinyint,
	Education nvarchar(40),
	Occupation nvarchar(100),
	HouseOwnerFlag nchar(1),
	NumberCarsOwned tinyint,
	AddressLine1 nvarchar(120),
	AddressLine2 nvarchar(120),
	City nvarchar(30),
	StateProvinceCode nvarchar(3),
	PostalCode nvarchar(15),
	Phone nvarchar(20),
	Salutation nvarchar(8),
	[Unknown] int)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ProspectiveBuyerKey));

CREATE TABLE $(schema).FactResellerSales(
	ProductKey int NOT NULL,
	OrderDateKey int NOT NULL,
	DueDateKey int NOT NULL,
	ShipDateKey int NOT NULL,
	ResellerKey int NOT NULL,
	EmployeeKey int NOT NULL,
	PromotionKey int NOT NULL,
	CurrencyKey int NOT NULL,
	SalesTerritoryKey int NOT NULL,
	SalesOrderNumber nvarchar(20) NOT NULL,
	SalesOrderLineNumber tinyint NOT NULL,
	RevisionNumber tinyint,
	OrderQuantity smallint,
	UnitPrice money,
	ExtendedAmount money,
	UnitPriceDiscountPct float,
	DiscountAmount float,
	ProductStandardCost money,
	TotalProductCost money,
	SalesAmount money,
	TaxAmt money,
	Freight money,
	CarrierTrackingNumber nvarchar(25),
	CustomerPONumber nvarchar(25))
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(ProductKey),
      PARTITION(OrderDateKey
      RANGE RIGHT FOR VALUES (
            20000101,20010101,20020101,20030101,20040101,20050101,20060101,20070101,20080101,20090101,
            20100101,20110101,20120101,20130101,20140101,20150101,20160101,20170101,20180101,20190101,
            20200101,20210101,20220101,20230101,20240101,20250101,20260101,20270101,20280101,20290101)));

CREATE TABLE $(schema).FactSalesQuota(
	SalesQuotaKey int NOT NULL,
	EmployeeKey int NOT NULL,
	DateKey int NOT NULL,
	CalendarYear smallint NOT NULL,
	CalendarQuarter tinyint NOT NULL,
	SalesAmountQuota money NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(SalesQuotaKey));

CREATE TABLE $(schema).FactSurveyResponse(
	SurveyResponseKey int NOT NULL,
	DateKey int NOT NULL,
	CustomerKey int NOT NULL,
	ProductCategoryKey int NOT NULL,
	EnglishProductCategoryName nvarchar(50) NOT NULL,
	ProductSubcategoryKey int NOT NULL,
	EnglishProductSubcategoryName nvarchar(50) NOT NULL)
WITH (CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH(CustomerKey));

GO

CREATE VIEW $(schema).AggregateSales
AS SELECT FIS.SalesAmount, DG.PostalCode, DC.YearlyIncome AS CustomerIncome,  DD.FullDateAlternateKey AS OrderDate
FROM $(schema).FactInternetSales AS FIS  
       JOIN $(schema).DimCustomer AS DC 
       ON FIS.CustomerKey = DC.CustomerKey
       JOIN $(schema).DimDate AS DD
       ON FIS.OrderDateKey = DD.DateKey
       JOIN $(schema).DimGeography AS DG 
              ON DC.GeographyKey = DG.GeographyKey;
			  
GO
			  
-- Creating Historical Sales Data as View (ie, Avoid materializing the results)
CREATE VIEW $(schema).SalesFromPastYears
AS
SELECT
    a.ProductKey,
    SalesOrderNumber
    ,SalesOrderLineNumber
    ,p.EnglishProductName as ProductName
    ,st.SalesTerritoryCountry
    ,OrderQuantity
    ,UnitPrice
    ,ExtendedAmount
    ,SalesAmount
    ,(convert(date, CAST(OrderDateKey as varchar))) AS [OrderDate]
FROM $(schema).[FactInternetSales] a
inner join $(schema).DimProduct p on a.ProductKey = p.ProductKey
inner join $(schema).DimSalesTerritory st
on st.SalesTerritoryKey = a.SalesTerritoryKey
where year(convert(date, CAST(OrderDateKey as varchar))) < 2015;
