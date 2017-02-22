update statistics $(schema)[AdventureWorksDWBuildVersion];
update statistics $(schema)[DatabaseLog];
update statistics $(schema)[DimAccount];
update statistics $(schema)[DimCurrency];
update statistics $(schema)[DimCustomer];
update statistics $(schema)[DimDate];
update statistics $(schema)[DimDepartmentGroup];
update statistics $(schema)[DimEmployee];
update statistics $(schema)[DimGeography];
update statistics $(schema)[DimOrganization];
update statistics $(schema)[DimProduct];
update statistics $(schema)[DimProductCategory];
update statistics $(schema)[DimProductSubcategory];
update statistics $(schema)[DimPromotion];
update statistics $(schema)[DimReseller];
update statistics $(schema)[DimSalesReason];
update statistics $(schema)[DimSalesTerritory];
update statistics $(schema)[DimScenario];
update statistics $(schema)[FactCallCenter];
update statistics $(schema)[FactCurrencyRate];
update statistics $(schema)[FactFinance];
update statistics $(schema)[FactInternetSales];
update statistics $(schema)[FactInternetSalesReason];
update statistics $(schema)[FactResellerSales];
update statistics $(schema)[FactSalesQuota];
update statistics $(schema)[FactSurveyResponse];
update statistics $(schema)[ProspectiveBuyer];
go

create statistics [DBVersion] on $(schema).[AdventureWorksDWBuildVersion] ([DBVersion]);
create statistics [VersionDate] on $(schema).[AdventureWorksDWBuildVersion] ([VersionDate]);
go

create statistics [DatabaseLogID] on $(schema).[DatabaseLog] ([DatabaseLogID]);
create statistics [PostTime] on $(schema).[DatabaseLog] ([PostTime]);
create statistics [DatabaseUser] on $(schema).[DatabaseLog] ([DatabaseUser]);
create statistics [Event] on $(schema).[DatabaseLog] ([Event]);
create statistics [Schema] on $(schema).[DatabaseLog] ([Schema]);
create statistics [Object] on $(schema).[DatabaseLog] ([Object]);
create statistics [TSQL] on $(schema).[DatabaseLog] ([TSQL]);
go

create statistics [AccountKey] on $(schema).[DimAccount] ([AccountKey]);
create statistics [ParentAccountKey] on $(schema).[DimAccount] ([ParentAccountKey]);
create statistics [AccountCodeAlternateKey] on $(schema).[DimAccount] ([AccountCodeAlternateKey]);
create statistics [ParentAccountCodeAlternateKey] on $(schema).[DimAccount] ([ParentAccountCodeAlternateKey]);
create statistics [AccountDescription] on $(schema).[DimAccount] ([AccountDescription]);
create statistics [AccountType] on $(schema).[DimAccount] ([AccountType]);
create statistics [Operator] on $(schema).[DimAccount] ([Operator]);
create statistics [CustomMembers] on $(schema).[DimAccount] ([CustomMembers]);
create statistics [ValueType] on $(schema).[DimAccount] ([ValueType]);
create statistics [CustomMemberOptions] on $(schema).[DimAccount] ([CustomMemberOptions]);
go

create statistics [CurrencyKey] on $(schema).[DimCurrency] ([CurrencyKey]);
create statistics [CurrencyAlternateKey] on $(schema).[DimCurrency] ([CurrencyAlternateKey]);
create statistics [CurrencyName] on $(schema).[DimCurrency] ([CurrencyName]);
go

create statistics [CustomerKey] on $(schema).[DimCustomer] ([CustomerKey]);
create statistics [GeographyKey] on $(schema).[DimCustomer] ([GeographyKey]);
create statistics [CustomerAlternateKey] on $(schema).[DimCustomer] ([CustomerAlternateKey]);
create statistics [Title] on $(schema).[DimCustomer] ([Title]);
create statistics [FirstName] on $(schema).[DimCustomer] ([FirstName]);
create statistics [MiddleName] on $(schema).[DimCustomer] ([MiddleName]);
create statistics [LastName] on $(schema).[DimCustomer] ([LastName]);
create statistics [NameStyle] on $(schema).[DimCustomer] ([NameStyle]);
create statistics [BirthDate] on $(schema).[DimCustomer] ([BirthDate]);
create statistics [MaritalStatus] on $(schema).[DimCustomer] ([MaritalStatus]);
create statistics [Suffix] on $(schema).[DimCustomer] ([Suffix]);
create statistics [Gender] on $(schema).[DimCustomer] ([Gender]);
create statistics [EmailAddress] on $(schema).[DimCustomer] ([EmailAddress]);
create statistics [YearlyIncome] on $(schema).[DimCustomer] ([YearlyIncome]);
create statistics [TotalChildren] on $(schema).[DimCustomer] ([TotalChildren]);
create statistics [NumberChildrenAtHome] on $(schema).[DimCustomer] ([NumberChildrenAtHome]);
create statistics [EnglishEducation] on $(schema).[DimCustomer] ([EnglishEducation]);
create statistics [SpanishEducation] on $(schema).[DimCustomer] ([SpanishEducation]);
create statistics [FrenchEducation] on $(schema).[DimCustomer] ([FrenchEducation]);
create statistics [EnglishOccupation] on $(schema).[DimCustomer] ([EnglishOccupation]);
create statistics [SpanishOccupation] on $(schema).[DimCustomer] ([SpanishOccupation]);
create statistics [FrenchOccupation] on $(schema).[DimCustomer] ([FrenchOccupation]);
create statistics [HouseOwnerFlag] on $(schema).[DimCustomer] ([HouseOwnerFlag]);
create statistics [NumberCarsOwned] on $(schema).[DimCustomer] ([NumberCarsOwned]);
create statistics [AddressLine1] on $(schema).[DimCustomer] ([AddressLine1]);
create statistics [AddressLine2] on $(schema).[DimCustomer] ([AddressLine2]);
create statistics [Phone] on $(schema).[DimCustomer] ([Phone]);
create statistics [DateFirstPurchase] on $(schema).[DimCustomer] ([DateFirstPurchase]);
create statistics [CommuteDistance] on $(schema).[DimCustomer] ([CommuteDistance]);
go

create statistics [DateKey] on $(schema).[DimDate] ([DateKey]);
create statistics [FullDateAlternateKey] on $(schema).[DimDate] ([FullDateAlternateKey]);
create statistics [DayNumberOfWeek] on $(schema).[DimDate] ([DayNumberOfWeek]);
create statistics [EnglishDayNameOfWeek] on $(schema).[DimDate] ([EnglishDayNameOfWeek]);
create statistics [SpanishDayNameOfWeek] on $(schema).[DimDate] ([SpanishDayNameOfWeek]);
create statistics [FrenchDayNameOfWeek] on $(schema).[DimDate] ([FrenchDayNameOfWeek]);
create statistics [DayNumberOfMonth] on $(schema).[DimDate] ([DayNumberOfMonth]);
create statistics [DayNumberOfYear] on $(schema).[DimDate] ([DayNumberOfYear]);
create statistics [WeekNumberOfYear] on $(schema).[DimDate] ([WeekNumberOfYear]);
create statistics [EnglishMonthName] on $(schema).[DimDate] ([EnglishMonthName]);
create statistics [SpanishMonthName] on $(schema).[DimDate] ([SpanishMonthName]);
create statistics [FrenchMonthName] on $(schema).[DimDate] ([FrenchMonthName]);
create statistics [MonthNumberOfYear] on $(schema).[DimDate] ([MonthNumberOfYear]);
create statistics [CalendarQuarter] on $(schema).[DimDate] ([CalendarQuarter]);
create statistics [CalendarYear] on $(schema).[DimDate] ([CalendarYear]);
create statistics [CalendarSemester] on $(schema).[DimDate] ([CalendarSemester]);
create statistics [FiscalQuarter] on $(schema).[DimDate] ([FiscalQuarter]);
create statistics [FiscalYear] on $(schema).[DimDate] ([FiscalYear]);
create statistics [FiscalSemester] on $(schema).[DimDate] ([FiscalSemester]);
go

create statistics [DepartmentGroupKey] on $(schema).[DimDepartmentGroup] ([DepartmentGroupKey]);
create statistics [ParentDepartmentGroupKey] on $(schema).[DimDepartmentGroup] ([ParentDepartmentGroupKey]);
create statistics [DepartmentGroupName] on $(schema).[DimDepartmentGroup] ([DepartmentGroupName]);
go

create statistics [EmployeeKey] on $(schema).[DimEmployee] ([EmployeeKey]);
create statistics [ParentEmployeeKey] on $(schema).[DimEmployee] ([ParentEmployeeKey]);
create statistics [EmployeeNationalIDAlternateKey] on $(schema).[DimEmployee] ([EmployeeNationalIDAlternateKey]);
create statistics [ParentEmployeeNationalIDAlternateKey] on $(schema).[DimEmployee] ([ParentEmployeeNationalIDAlternateKey]);
create statistics [SalesTerritoryKey] on $(schema).[DimEmployee] ([SalesTerritoryKey]);
create statistics [FirstName] on $(schema).[DimEmployee] ([FirstName]);
create statistics [LastName] on $(schema).[DimEmployee] ([LastName]);
create statistics [MiddleName] on $(schema).[DimEmployee] ([MiddleName]);
create statistics [NameStyle] on $(schema).[DimEmployee] ([NameStyle]);
create statistics [Title] on $(schema).[DimEmployee] ([Title]);
create statistics [HireDate] on $(schema).[DimEmployee] ([HireDate]);
create statistics [BirthDate] on $(schema).[DimEmployee] ([BirthDate]);
create statistics [LoginID] on $(schema).[DimEmployee] ([LoginID]);
create statistics [EmailAddress] on $(schema).[DimEmployee] ([EmailAddress]);
create statistics [Phone] on $(schema).[DimEmployee] ([Phone]);
create statistics [MaritalStatus] on $(schema).[DimEmployee] ([MaritalStatus]);
create statistics [EmergencyContactName] on $(schema).[DimEmployee] ([EmergencyContactName]);
create statistics [EmergencyContactPhone] on $(schema).[DimEmployee] ([EmergencyContactPhone]);
create statistics [SalariedFlag] on $(schema).[DimEmployee] ([SalariedFlag]);
create statistics [Gender] on $(schema).[DimEmployee] ([Gender]);
create statistics [PayFrequency] on $(schema).[DimEmployee] ([PayFrequency]);
create statistics [BaseRate] on $(schema).[DimEmployee] ([BaseRate]);
create statistics [VacationHours] on $(schema).[DimEmployee] ([VacationHours]);
create statistics [SickLeaveHours] on $(schema).[DimEmployee] ([SickLeaveHours]);
create statistics [CurrentFlag] on $(schema).[DimEmployee] ([CurrentFlag]);
create statistics [SalesPersonFlag] on $(schema).[DimEmployee] ([SalesPersonFlag]);
create statistics [DepartmentName] on $(schema).[DimEmployee] ([DepartmentName]);
create statistics [StartDate] on $(schema).[DimEmployee] ([StartDate]);
create statistics [EndDate] on $(schema).[DimEmployee] ([EndDate]);
create statistics [Status] on $(schema).[DimEmployee] ([Status]);
go

create statistics [GeographyKey] on $(schema).[DimGeography] ([GeographyKey]);
create statistics [City] on $(schema).[DimGeography] ([City]);
create statistics [StateProvinceCode] on $(schema).[DimGeography] ([StateProvinceCode]);
create statistics [StateProvinceName] on $(schema).[DimGeography] ([StateProvinceName]);
create statistics [CountryRegionCode] on $(schema).[DimGeography] ([CountryRegionCode]);
create statistics [EnglishCountryRegionName] on $(schema).[DimGeography] ([EnglishCountryRegionName]);
create statistics [SpanishCountryRegionName] on $(schema).[DimGeography] ([SpanishCountryRegionName]);
create statistics [FrenchCountryRegionName] on $(schema).[DimGeography] ([FrenchCountryRegionName]);
create statistics [PostalCode] on $(schema).[DimGeography] ([PostalCode]);
create statistics [SalesTerritoryKey] on $(schema).[DimGeography] ([SalesTerritoryKey]);
go

create statistics [OrganizationKey] on $(schema).[DimOrganization] ([OrganizationKey]);
create statistics [ParentOrganizationKey] on $(schema).[DimOrganization] ([ParentOrganizationKey]);
create statistics [PercentageOfOwnership] on $(schema).[DimOrganization] ([PercentageOfOwnership]);
create statistics [OrganizationName] on $(schema).[DimOrganization] ([OrganizationName]);
create statistics [CurrencyKey] on $(schema).[DimOrganization] ([CurrencyKey]);
go

create statistics [ProductKey] on $(schema).[DimProduct] ([ProductKey]);
create statistics [ProductAlternateKey] on $(schema).[DimProduct] ([ProductAlternateKey]);
create statistics [ProductSubcategoryKey] on $(schema).[DimProduct] ([ProductSubcategoryKey]);
create statistics [WeightUnitMeasureCode] on $(schema).[DimProduct] ([WeightUnitMeasureCode]);
create statistics [SizeUnitMeasureCode] on $(schema).[DimProduct] ([SizeUnitMeasureCode]);
create statistics [EnglishProductName] on $(schema).[DimProduct] ([EnglishProductName]);
create statistics [SpanishProductName] on $(schema).[DimProduct] ([SpanishProductName]);
create statistics [FrenchProductName] on $(schema).[DimProduct] ([FrenchProductName]);
create statistics [StandardCost] on $(schema).[DimProduct] ([StandardCost]);
create statistics [FinishedGoodsFlag] on $(schema).[DimProduct] ([FinishedGoodsFlag]);
create statistics [Color] on $(schema).[DimProduct] ([Color]);
create statistics [SafetyStockLevel] on $(schema).[DimProduct] ([SafetyStockLevel]);
create statistics [ReorderPoint] on $(schema).[DimProduct] ([ReorderPoint]);
create statistics [ListPrice] on $(schema).[DimProduct] ([ListPrice]);
create statistics [Size] on $(schema).[DimProduct] ([Size]);
create statistics [SizeRange] on $(schema).[DimProduct] ([SizeRange]);
create statistics [Weight] on $(schema).[DimProduct] ([Weight]);
create statistics [DaysToManufacture] on $(schema).[DimProduct] ([DaysToManufacture]);
create statistics [ProductLine] on $(schema).[DimProduct] ([ProductLine]);
create statistics [DealerPrice] on $(schema).[DimProduct] ([DealerPrice]);
create statistics [Class] on $(schema).[DimProduct] ([Class]);
create statistics [Style] on $(schema).[DimProduct] ([Style]);
create statistics [ModelName] on $(schema).[DimProduct] ([ModelName]);
create statistics [EnglishDescription] on $(schema).[DimProduct] ([EnglishDescription]);
create statistics [FrenchDescription] on $(schema).[DimProduct] ([FrenchDescription]);
create statistics [ChineseDescription] on $(schema).[DimProduct] ([ChineseDescription]);
create statistics [ArabicDescription] on $(schema).[DimProduct] ([ArabicDescription]);
create statistics [HebrewDescription] on $(schema).[DimProduct] ([HebrewDescription]);
create statistics [ThaiDescription] on $(schema).[DimProduct] ([ThaiDescription]);
create statistics [GermanDescription] on $(schema).[DimProduct] ([GermanDescription]);
create statistics [JapaneseDescription] on $(schema).[DimProduct] ([JapaneseDescription]);
create statistics [TurkishDescription] on $(schema).[DimProduct] ([TurkishDescription]);
create statistics [StartDate] on $(schema).[DimProduct] ([StartDate]);
create statistics [EndDate] on $(schema).[DimProduct] ([EndDate]);
create statistics [Status] on $(schema).[DimProduct] ([Status]);
go

create statistics [ProductCategoryKey] on $(schema).[DimProductCategory] ([ProductCategoryKey]);
create statistics [ProductCategoryAlternateKey] on $(schema).[DimProductCategory] ([ProductCategoryAlternateKey]);
create statistics [EnglishProductCategoryName] on $(schema).[DimProductCategory] ([EnglishProductCategoryName]);
create statistics [SpanishProductCategoryName] on $(schema).[DimProductCategory] ([SpanishProductCategoryName]);
create statistics [FrenchProductCategoryName] on $(schema).[DimProductCategory] ([FrenchProductCategoryName]);
go

create statistics [ProductSubcategoryKey] on $(schema).[DimProductSubcategory] ([ProductSubcategoryKey]);
create statistics [ProductSubcategoryAlternateKey] on $(schema).[DimProductSubcategory] ([ProductSubcategoryAlternateKey]);
create statistics [EnglishProductSubcategoryName] on $(schema).[DimProductSubcategory] ([EnglishProductSubcategoryName]);
create statistics [SpanishProductSubcategoryName] on $(schema).[DimProductSubcategory] ([SpanishProductSubcategoryName]);
create statistics [FrenchProductSubcategoryName] on $(schema).[DimProductSubcategory] ([FrenchProductSubcategoryName]);
create statistics [ProductCategoryKey] on $(schema).[DimProductSubcategory] ([ProductCategoryKey]);
go

create statistics [PromotionKey] on $(schema).[DimPromotion] ([PromotionKey]);
create statistics [PromotionAlternateKey] on $(schema).[DimPromotion] ([PromotionAlternateKey]);
create statistics [EnglishPromotionName] on $(schema).[DimPromotion] ([EnglishPromotionName]);
create statistics [SpanishPromotionName] on $(schema).[DimPromotion] ([SpanishPromotionName]);
create statistics [FrenchPromotionName] on $(schema).[DimPromotion] ([FrenchPromotionName]);
create statistics [DiscountPct] on $(schema).[DimPromotion] ([DiscountPct]);
create statistics [EnglishPromotionType] on $(schema).[DimPromotion] ([EnglishPromotionType]);
create statistics [SpanishPromotionType] on $(schema).[DimPromotion] ([SpanishPromotionType]);
create statistics [FrenchPromotionType] on $(schema).[DimPromotion] ([FrenchPromotionType]);
create statistics [EnglishPromotionCategory] on $(schema).[DimPromotion] ([EnglishPromotionCategory]);
create statistics [SpanishPromotionCategory] on $(schema).[DimPromotion] ([SpanishPromotionCategory]);
create statistics [FrenchPromotionCategory] on $(schema).[DimPromotion] ([FrenchPromotionCategory]);
create statistics [StartDate] on $(schema).[DimPromotion] ([StartDate]);
create statistics [EndDate] on $(schema).[DimPromotion] ([EndDate]);
create statistics [MinQty] on $(schema).[DimPromotion] ([MinQty]);
create statistics [MaxQty] on $(schema).[DimPromotion] ([MaxQty]);
go

create statistics [ResellerKey] on $(schema).[DimReseller] ([ResellerKey]);
create statistics [GeographyKey] on $(schema).[DimReseller] ([GeographyKey]);
create statistics [ResellerAlternateKey] on $(schema).[DimReseller] ([ResellerAlternateKey]);
create statistics [Phone] on $(schema).[DimReseller] ([Phone]);
create statistics [BusinessType] on $(schema).[DimReseller] ([BusinessType]);
create statistics [ResellerName] on $(schema).[DimReseller] ([ResellerName]);
create statistics [NumberEmployees] on $(schema).[DimReseller] ([NumberEmployees]);
create statistics [OrderFrequency] on $(schema).[DimReseller] ([OrderFrequency]);
create statistics [OrderMonth] on $(schema).[DimReseller] ([OrderMonth]);
create statistics [FirstOrderYear] on $(schema).[DimReseller] ([FirstOrderYear]);
create statistics [LastOrderYear] on $(schema).[DimReseller] ([LastOrderYear]);
create statistics [ProductLine] on $(schema).[DimReseller] ([ProductLine]);
create statistics [AddressLine1] on $(schema).[DimReseller] ([AddressLine1]);
create statistics [AddressLine2] on $(schema).[DimReseller] ([AddressLine2]);
create statistics [AnnualSales] on $(schema).[DimReseller] ([AnnualSales]);
create statistics [BankName] on $(schema).[DimReseller] ([BankName]);
create statistics [MinPaymentType] on $(schema).[DimReseller] ([MinPaymentType]);
create statistics [MinPaymentAmount] on $(schema).[DimReseller] ([MinPaymentAmount]);
create statistics [AnnualRevenue] on $(schema).[DimReseller] ([AnnualRevenue]);
create statistics [YearOpened] on $(schema).[DimReseller] ([YearOpened]);
go

create statistics [SalesReasonKey] on $(schema).[DimSalesReason] ([SalesReasonKey]);
create statistics [SalesReasonAlternateKey] on $(schema).[DimSalesReason] ([SalesReasonAlternateKey]);
create statistics [SalesReasonName] on $(schema).[DimSalesReason] ([SalesReasonName]);
create statistics [SalesReasonReasonType] on $(schema).[DimSalesReason] ([SalesReasonReasonType]);
go

create statistics [SalesTerritoryKey] on $(schema).[DimSalesTerritory] ([SalesTerritoryKey]);
create statistics [SalesTerritoryAlternateKey] on $(schema).[DimSalesTerritory] ([SalesTerritoryAlternateKey]);
create statistics [SalesTerritoryRegion] on $(schema).[DimSalesTerritory] ([SalesTerritoryRegion]);
create statistics [SalesTerritoryCountry] on $(schema).[DimSalesTerritory] ([SalesTerritoryCountry]);
create statistics [SalesTerritoryGroup] on $(schema).[DimSalesTerritory] ([SalesTerritoryGroup]);
go

create statistics [ScenarioKey] on $(schema).[DimScenario] ([ScenarioKey]);
create statistics [ScenarioName] on $(schema).[DimScenario] ([ScenarioName]);
go

create statistics [FactCallCenterID] on $(schema).[FactCallCenter] ([FactCallCenterID]);
create statistics [DateKey] on $(schema).[FactCallCenter] ([DateKey]);
create statistics [WageType] on $(schema).[FactCallCenter] ([WageType]);
create statistics [Shift] on $(schema).[FactCallCenter] ([Shift]);
create statistics [LevelOneOperators] on $(schema).[FactCallCenter] ([LevelOneOperators]);
create statistics [LevelTwoOperators] on $(schema).[FactCallCenter] ([LevelTwoOperators]);
create statistics [TotalOperators] on $(schema).[FactCallCenter] ([TotalOperators]);
create statistics [Calls] on $(schema).[FactCallCenter] ([Calls]);
create statistics [AutomaticResponses] on $(schema).[FactCallCenter] ([AutomaticResponses]);
create statistics [Orders] on $(schema).[FactCallCenter] ([Orders]);
create statistics [IssuesRaised] on $(schema).[FactCallCenter] ([IssuesRaised]);
create statistics [AverageTimePerIssue] on $(schema).[FactCallCenter] ([AverageTimePerIssue]);
create statistics [ServiceGrade] on $(schema).[FactCallCenter] ([ServiceGrade]);
go

create statistics [CurrencyKey] on $(schema).[FactCurrencyRate] ([CurrencyKey]);
create statistics [DateKey] on $(schema).[FactCurrencyRate] ([DateKey]);
create statistics [AverageRate] on $(schema).[FactCurrencyRate] ([AverageRate]);
create statistics [EndOfDayRate] on $(schema).[FactCurrencyRate] ([EndOfDayRate]);
go

create statistics [FinanceKey] on $(schema).[FactFinance] ([FinanceKey]);
create statistics [DateKey] on $(schema).[FactFinance] ([DateKey]);
create statistics [OrganizationKey] on $(schema).[FactFinance] ([OrganizationKey]);
create statistics [DepartmentGroupKey] on $(schema).[FactFinance] ([DepartmentGroupKey]);
create statistics [ScenarioKey] on $(schema).[FactFinance] ([ScenarioKey]);
create statistics [AccountKey] on $(schema).[FactFinance] ([AccountKey]);
create statistics [Amount] on $(schema).[FactFinance] ([Amount]);
go

create statistics [ProductKey] on $(schema).[FactInternetSales] ([ProductKey]);
create statistics [OrderDateKey] on $(schema).[FactInternetSales] ([OrderDateKey]);
create statistics [DueDateKey] on $(schema).[FactInternetSales] ([DueDateKey]);
create statistics [ShipDateKey] on $(schema).[FactInternetSales] ([ShipDateKey]);
create statistics [CustomerKey] on $(schema).[FactInternetSales] ([CustomerKey]);
create statistics [PromotionKey] on $(schema).[FactInternetSales] ([PromotionKey]);
create statistics [CurrencyKey] on $(schema).[FactInternetSales] ([CurrencyKey]);
create statistics [SalesTerritoryKey] on $(schema).[FactInternetSales] ([SalesTerritoryKey]);
create statistics [SalesOrderNumber] on $(schema).[FactInternetSales] ([SalesOrderNumber]);
create statistics [SalesOrderLineNumber] on $(schema).[FactInternetSales] ([SalesOrderLineNumber]);
create statistics [RevisionNumber] on $(schema).[FactInternetSales] ([RevisionNumber]);
create statistics [OrderQuantity] on $(schema).[FactInternetSales] ([OrderQuantity]);
create statistics [UnitPrice] on $(schema).[FactInternetSales] ([UnitPrice]);
create statistics [ExtendedAmount] on $(schema).[FactInternetSales] ([ExtendedAmount]);
create statistics [UnitPriceDiscountPct] on $(schema).[FactInternetSales] ([UnitPriceDiscountPct]);
create statistics [DiscountAmount] on $(schema).[FactInternetSales] ([DiscountAmount]);
create statistics [ProductStandardCost] on $(schema).[FactInternetSales] ([ProductStandardCost]);
create statistics [TotalProductCost] on $(schema).[FactInternetSales] ([TotalProductCost]);
create statistics [SalesAmount] on $(schema).[FactInternetSales] ([SalesAmount]);
create statistics [TaxAmt] on $(schema).[FactInternetSales] ([TaxAmt]);
create statistics [Freight] on $(schema).[FactInternetSales] ([Freight]);
create statistics [CarrierTrackingNumber] on $(schema).[FactInternetSales] ([CarrierTrackingNumber]);
create statistics [CustomerPONumber] on $(schema).[FactInternetSales] ([CustomerPONumber]);
go

create statistics [SalesOrderNumber] on $(schema).[FactInternetSalesReason] ([SalesOrderNumber]);
create statistics [SalesOrderLineNumber] on $(schema).[FactInternetSalesReason] ([SalesOrderLineNumber]);
create statistics [SalesReasonKey] on $(schema).[FactInternetSalesReason] ([SalesReasonKey]);
go

create statistics [ProductKey] on $(schema).[FactResellerSales] ([ProductKey]);
create statistics [OrderDateKey] on $(schema).[FactResellerSales] ([OrderDateKey]);
create statistics [DueDateKey] on $(schema).[FactResellerSales] ([DueDateKey]);
create statistics [ShipDateKey] on $(schema).[FactResellerSales] ([ShipDateKey]);
create statistics [ResellerKey] on $(schema).[FactResellerSales] ([ResellerKey]);
create statistics [EmployeeKey] on $(schema).[FactResellerSales] ([EmployeeKey]);
create statistics [PromotionKey] on $(schema).[FactResellerSales] ([PromotionKey]);
create statistics [CurrencyKey] on $(schema).[FactResellerSales] ([CurrencyKey]);
create statistics [SalesTerritoryKey] on $(schema).[FactResellerSales] ([SalesTerritoryKey]);
create statistics [SalesOrderNumber] on $(schema).[FactResellerSales] ([SalesOrderNumber]);
create statistics [SalesOrderLineNumber] on $(schema).[FactResellerSales] ([SalesOrderLineNumber]);
create statistics [RevisionNumber] on $(schema).[FactResellerSales] ([RevisionNumber]);
create statistics [OrderQuantity] on $(schema).[FactResellerSales] ([OrderQuantity]);
create statistics [UnitPrice] on $(schema).[FactResellerSales] ([UnitPrice]);
create statistics [ExtendedAmount] on $(schema).[FactResellerSales] ([ExtendedAmount]);
create statistics [UnitPriceDiscountPct] on $(schema).[FactResellerSales] ([UnitPriceDiscountPct]);
create statistics [DiscountAmount] on $(schema).[FactResellerSales] ([DiscountAmount]);
create statistics [ProductStandardCost] on $(schema).[FactResellerSales] ([ProductStandardCost]);
create statistics [TotalProductCost] on $(schema).[FactResellerSales] ([TotalProductCost]);
create statistics [SalesAmount] on $(schema).[FactResellerSales] ([SalesAmount]);
create statistics [TaxAmt] on $(schema).[FactResellerSales] ([TaxAmt]);
create statistics [Freight] on $(schema).[FactResellerSales] ([Freight]);
create statistics [CarrierTrackingNumber] on $(schema).[FactResellerSales] ([CarrierTrackingNumber]);
create statistics [CustomerPONumber] on $(schema).[FactResellerSales] ([CustomerPONumber]);
go

create statistics [SalesQuotaKey] on $(schema).[FactSalesQuota] ([SalesQuotaKey]);
create statistics [EmployeeKey] on $(schema).[FactSalesQuota] ([EmployeeKey]);
create statistics [DateKey] on $(schema).[FactSalesQuota] ([DateKey]);
create statistics [CalendarYear] on $(schema).[FactSalesQuota] ([CalendarYear]);
create statistics [CalendarQuarter] on $(schema).[FactSalesQuota] ([CalendarQuarter]);
create statistics [SalesAmountQuota] on $(schema).[FactSalesQuota] ([SalesAmountQuota]);
go

create statistics [SurveyResponseKey] on $(schema).[FactSurveyResponse] ([SurveyResponseKey]);
create statistics [DateKey] on $(schema).[FactSurveyResponse] ([DateKey]);
create statistics [CustomerKey] on $(schema).[FactSurveyResponse] ([CustomerKey]);
create statistics [ProductCategoryKey] on $(schema).[FactSurveyResponse] ([ProductCategoryKey]);
create statistics [EnglishProductCategoryName] on $(schema).[FactSurveyResponse] ([EnglishProductCategoryName]);
create statistics [ProductSubcategoryKey] on $(schema).[FactSurveyResponse] ([ProductSubcategoryKey]);
create statistics [EnglishProductSubcategoryName] on $(schema).[FactSurveyResponse] ([EnglishProductSubcategoryName]);
go

create statistics [ProspectiveBuyerKey] on $(schema).[ProspectiveBuyer] ([ProspectiveBuyerKey]);
create statistics [ProspectAlternateKey] on $(schema).[ProspectiveBuyer] ([ProspectAlternateKey]);
create statistics [FirstName] on $(schema).[ProspectiveBuyer] ([FirstName]);
create statistics [MiddleName] on $(schema).[ProspectiveBuyer] ([MiddleName]);
create statistics [LastName] on $(schema).[ProspectiveBuyer] ([LastName]);
create statistics [BirthDate] on $(schema).[ProspectiveBuyer] ([BirthDate]);
create statistics [MaritalStatus] on $(schema).[ProspectiveBuyer] ([MaritalStatus]);
create statistics [Gender] on $(schema).[ProspectiveBuyer] ([Gender]);
create statistics [EmailAddress] on $(schema).[ProspectiveBuyer] ([EmailAddress]);
create statistics [YearlyIncome] on $(schema).[ProspectiveBuyer] ([YearlyIncome]);
create statistics [TotalChildren] on $(schema).[ProspectiveBuyer] ([TotalChildren]);
create statistics [NumberChildrenAtHome] on $(schema).[ProspectiveBuyer] ([NumberChildrenAtHome]);
create statistics [Education] on $(schema).[ProspectiveBuyer] ([Education]);
create statistics [Occupation] on $(schema).[ProspectiveBuyer] ([Occupation]);
create statistics [HouseOwnerFlag] on $(schema).[ProspectiveBuyer] ([HouseOwnerFlag]);
create statistics [NumberCarsOwned] on $(schema).[ProspectiveBuyer] ([NumberCarsOwned]);
create statistics [AddressLine1] on $(schema).[ProspectiveBuyer] ([AddressLine1]);
create statistics [AddressLine2] on $(schema).[ProspectiveBuyer] ([AddressLine2]);
create statistics [City] on $(schema).[ProspectiveBuyer] ([City]);
create statistics [StateProvinceCode] on $(schema).[ProspectiveBuyer] ([StateProvinceCode]);
create statistics [PostalCode] on $(schema).[ProspectiveBuyer] ([PostalCode]);
create statistics [Phone] on $(schema).[ProspectiveBuyer] ([Phone]);
create statistics [Salutation] on $(schema).[ProspectiveBuyer] ([Salutation]);
create statistics [Unknown] on $(schema).[ProspectiveBuyer] ([Unknown]);
go
