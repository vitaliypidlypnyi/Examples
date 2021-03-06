
USE [Empeek]

/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AuditTrailRecord]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditTrailRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[Method] [nvarchar](max) NULL,
	[Query] [nvarchar](max) NULL,
	[Data] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UserAccountId] [int] NULL,
 CONSTRAINT [PK_dbo.AuditTrailRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CashMethods]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashMethods](
	[Id] [int] NOT NULL,
 CONSTRAINT [PK_dbo.CashMethods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCards](
	[Id] [int] NOT NULL,
	[CreditCardNumber] [nvarchar](max) NULL,
	[IsPrivatBank] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.CreditCards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[Email] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerInvoice]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[From] [nvarchar](255) NULL,
	[To] [nvarchar](255) NULL,
	[Number] [int] NOT NULL,
	[InvoiceDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[Discount] [decimal](18, 2) NOT NULL,
	[Tax] [decimal](18, 2) NOT NULL,
	[Shipping] [decimal](18, 2) NOT NULL,
	[Notes] [nvarchar](1024) NULL,
	[Terms] [nvarchar](1024) NULL,
	[IsSent] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[CustomerName] [nvarchar](128) NULL,
	[CustomerEmail] [nvarchar](256) NULL,
 CONSTRAINT [PK_dbo.CustomerInvoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerInvoiceCurrency]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoiceCurrency](
	[CustomerInvoiceId] [int] NOT NULL,
	[CurrencyIsoCode] [nvarchar](max) NULL,
	[CurrencyName] [nvarchar](max) NULL,
	[CurrencySymbol] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.CustomerInvoiceCurrency] PRIMARY KEY CLUSTERED 
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerInvoiceFields]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoiceFields](
	[CustomerInvoiceId] [int] NOT NULL,
	[Tax] [nvarchar](6) NULL,
	[Discount] [nvarchar](6) NULL,
	[Shipping] [nvarchar](6) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.CustomerInvoiceFields] PRIMARY KEY CLUSTERED 
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerInvoiceLineItem]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoiceLineItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerInvoiceId] [int] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.CustomerInvoiceLineItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerInvoicePayment]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoicePayment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerInvoiceId] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.CustomerInvoicePayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerInvoiceTemplate]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoiceTemplate](
	[CustomerInvoiceId] [int] NOT NULL,
	[Header] [nvarchar](64) NULL,
	[ToTile] [nvarchar](64) NULL,
	[FromTitle] [nvarchar](64) NULL,
	[DateTitle] [nvarchar](64) NULL,
	[DueDateTitle] [nvarchar](64) NULL,
	[QuantityHeader] [nvarchar](64) NULL,
	[ItemHeader] [nvarchar](64) NULL,
	[UnitCostHeader] [nvarchar](64) NULL,
	[AmountHeader] [nvarchar](64) NULL,
	[SubTotalTitle] [nvarchar](64) NULL,
	[DiscountTitle] [nvarchar](64) NULL,
	[TaxTitle] [nvarchar](64) NULL,
	[ShippingTitle] [nvarchar](64) NULL,
	[TotalTitle] [nvarchar](64) NULL,
	[AmountPaidTitle] [nvarchar](64) NULL,
	[BalanceTitle] [nvarchar](64) NULL,
	[TermsTitle] [nvarchar](64) NULL,
	[NotesTitle] [nvarchar](64) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.CustomerInvoiceTemplate] PRIMARY KEY CLUSTERED 
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Error]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MessageType] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[ClassName] [nvarchar](max) NULL,
	[MethodName] [nvarchar](max) NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Error] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceHeader]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceHeader](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[CompanyName] [nvarchar](max) NULL,
	[CreatedByUserFirstName] [nvarchar](max) NULL,
	[CreatedByUserId] [int] NOT NULL,
	[CreatedByUserLastName] [nvarchar](max) NULL,
	[CurrencyCode] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[DisplayDate] [nvarchar](max) NULL,
	[EditedByUserFirstName] [nvarchar](max) NULL,
	[EditedByUserLastName] [nvarchar](max) NULL,
	[ExportedByUserFirstName] [nvarchar](max) NULL,
	[ExportedByUserLastName] [nvarchar](max) NULL,
	[ExportedDate] [datetime] NULL,
	[ExpotedByUserId] [int] NULL,
	[FixedCost] [decimal](18, 2) NULL,
	[Number] [nvarchar](max) NULL,
	[PoNumber] [int] NULL,
	[ProjectId] [int] NOT NULL,
	[ProjectName] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[TeamWorkStatus] [int] NOT NULL,
	[TeamWorkId] [int] NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[TotalHours] [decimal](18, 2) NOT NULL,
	[UpdatedByUserId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.InvoiceHeader] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceItem]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Billable] [bit] NOT NULL,
	[Cost] [decimal](18, 2) NOT NULL,
	[DateLoggedUtc] [datetime] NOT NULL,
	[DecimalHours] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Minutes] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[TaskId] [int] NULL,
	[TaskName] [nvarchar](max) NULL,
	[TimeLogId] [int] NOT NULL,
	[UserFirstName] [nvarchar](max) NULL,
	[TeamWorkUserId] [int] NOT NULL,
	[UserLastName] [nvarchar](max) NULL,
	[InvoiceId] [int] NOT NULL,
	[Billed] [bit] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.InvoiceItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[PaymentType] [int] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Type] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.PaymentMethods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostponedMessage]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostponedMessage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[To] [nvarchar](max) NULL,
	[Subject] [nvarchar](max) NULL,
	[Body] [nvarchar](max) NULL,
	[IsBodyHtml] [bit] NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[WasSent] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.PostponedMessage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[IsShownOnTimeline] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
	[StartDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[Deadline] [datetime] NULL,
	[ProjectCost] [real] NULL,
	[EstimatedHours] [real] NULL,
	[CustomerId] [int] NULL,
	[IsDeleted] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectUserAccount]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectUserAccount](
	[ProjectId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[EndDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[Capacity] [int] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.ProjectUserAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Report]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Xml] [nvarchar](max) NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Report] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalaryRate]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryRate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateFrom] [datetime] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.SalaryRate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalesProject]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesProject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[ProjectId] [int] NOT NULL,
	[SalesManagerId] [int] NOT NULL,
	[IsEnded] [bit] NOT NULL,
	[ProjectType] [int] NOT NULL,
	[CostRate] [real] NULL,
	[StartDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[Description] [nvarchar](1024) NULL,
 CONSTRAINT [PK_dbo.SalesProject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SalesTransaction]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesTransaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [float] NOT NULL,
	[Compensation] [float] NOT NULL,
	[SalesProjectId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[TransactionId] [int] NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_dbo.SalesTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SkrillAccounts]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkrillAccounts](
	[Id] [int] NOT NULL,
	[Email] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.SkrillAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimeEntry]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[CompanyName] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DateUserPerspective] [datetime] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[HasStartTime] [bit] NOT NULL,
	[Hours] [int] NOT NULL,
	[InvoiceNumber] [int] NOT NULL,
	[IsBillable] [bit] NOT NULL,
	[IsBilled] [bit] NOT NULL,
	[Minutes] [int] NOT NULL,
	[ParentTaskId] [int] NOT NULL,
	[ParentTaskName] [nvarchar](max) NULL,
	[PersonFirstName] [nvarchar](max) NULL,
	[PersonId] [int] NOT NULL,
	[PersonLastName] [nvarchar](max) NULL,
	[ProjectId] [int] NOT NULL,
	[ProjectName] [nvarchar](max) NULL,
	[TaskIsPrivate] [bit] NOT NULL,
	[TaskIsSubtask] [bit] NOT NULL,
	[TeamWorkId] [int] NOT NULL,
	[TicketId] [int] NOT NULL,
	[TodoItemId] [int] NOT NULL,
	[TodoItemName] [nvarchar](max) NULL,
	[TodoListId] [int] NOT NULL,
	[TodoListName] [nvarchar](max) NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UserAccount_Id] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.TimeEntry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Date] [datetime] NOT NULL,
	[TransactionType] [nvarchar](max) NULL,
	[Description] [nvarchar](200) NULL,
	[AmountUah] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[ExchangeRate] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[UserPaymentId] [int] NULL DEFAULT ((0)),
	[PaymentId] [int] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Transaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressCity] [nvarchar](max) NULL,
	[AddressCountry] [nvarchar](max) NULL,
	[AddressLine1] [nvarchar](max) NULL,
	[AddressLine2] [nvarchar](max) NULL,
	[AddressState] [nvarchar](max) NULL,
	[Administrator] [bit] NOT NULL,
	[AvatarUrl] [nvarchar](max) NULL,
	[CompanyId] [int] NOT NULL,
	[CompanyName] [nvarchar](max) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[EmailAddress] [nvarchar](254) NULL,
	[FirstName] [nvarchar](max) NULL,
	[HasAccessToNewProjects] [bit] NOT NULL,
	[ImHandle] [nvarchar](max) NULL,
	[ImService] [nvarchar](max) NULL,
	[InOwnerCompany] [bit] NOT NULL,
	[LastChangedOn] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[LastName] [nvarchar](max) NULL,
	[LoginCount] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[OpenId] [int] NULL,
	[PhoneNumberHome] [nvarchar](max) NULL,
	[PhoneNumberMobile] [nvarchar](max) NULL,
	[PhoneNumberOffice] [nvarchar](max) NULL,
	[Pid] [int] NULL,
	[SiteOwner] [bit] NOT NULL,
	[TeamWorkId] [int] NOT NULL,
	[TextFormat] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[Twitter] [nvarchar](max) NULL,
	[UserInvited] [int] NOT NULL,
	[UserInvitedDate] [datetime] NULL,
	[UserInvitedStatus] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[UserType] [nvarchar](max) NULL,
	[UserUuId] [int] NULL,
	[DefaultPaymentMethodId] [int] NULL,
	[IsActive] [bit] NOT NULL DEFAULT ((1)),
	[Password] [nchar](32) NULL,
	[HireDate] [datetime] NULL,
	[BirthDate] [datetime] NULL,
	[EnglishLevel] [int] NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.UserAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPayment]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPayment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [real] NOT NULL DEFAULT ((0)),
	[UserId] [int] NOT NULL DEFAULT ((0)),
	[PaymentId] [int] NOT NULL DEFAULT ((0)),
	[PaymentFrequency] [int] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.UserPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPaymentMethods]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPaymentMethods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMethodId] [int] NOT NULL,
	[UserAccountId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.UserPaymentMethods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserAccountId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModDate] [datetime] NOT NULL DEFAULT ('1900-01-01T00:00:00.000'),
	[ModBy] [int] NOT NULL DEFAULT ((0)),
	[CreateBy] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.UserRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vacation]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vacation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[DateFrom] [datetime] NOT NULL,
	[DateTo] [datetime] NOT NULL,
	[DurationDays] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
	[ConfirmedNotificationMessageId] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Vacation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VacationInitialDays]    Script Date: 10/6/2016 10:36:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacationInitialDays](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TotalDays] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModBy] [int] NOT NULL,
	[CreateBy] [int] NOT NULL,
 CONSTRAINT [PK_dbo.VacationInitialDays] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_UserAccountId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserAccountId] ON [dbo].[AuditTrailRecord]
(
	[UserAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Id]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_Id] ON [dbo].[CashMethods]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Id]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_Id] ON [dbo].[CreditCards]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerInvoiceId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerInvoiceId] ON [dbo].[CustomerInvoiceCurrency]
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerInvoiceId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerInvoiceId] ON [dbo].[CustomerInvoiceFields]
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerInvoiceId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerInvoiceId] ON [dbo].[CustomerInvoiceLineItem]
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerInvoiceId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerInvoiceId] ON [dbo].[CustomerInvoicePayment]
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerInvoiceId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerInvoiceId] ON [dbo].[CustomerInvoiceTemplate]
(
	[CustomerInvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TeamWorkId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TeamWorkId] ON [dbo].[InvoiceHeader]
(
	[TeamWorkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_InvoiceId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_InvoiceId] ON [dbo].[InvoiceItem]
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerId] ON [dbo].[Project]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProjectId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProjectId] ON [dbo].[ProjectUserAccount]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[ProjectUserAccount]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SalaryRateUniqDate]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [SalaryRateUniqDate] ON [dbo].[SalaryRate]
(
	[UserId] ASC,
	[DateFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProjectId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProjectId] ON [dbo].[SalesProject]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SalesManagerId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_SalesManagerId] ON [dbo].[SalesProject]
(
	[SalesManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SalesProjectId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_SalesProjectId] ON [dbo].[SalesTransaction]
(
	[SalesProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TransactionId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_TransactionId] ON [dbo].[SalesTransaction]
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Id]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_Id] ON [dbo].[SkrillAccounts]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TeamWorkId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TeamWorkId] ON [dbo].[TimeEntry]
(
	[TeamWorkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserAccount_Id]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserAccount_Id] ON [dbo].[TimeEntry]
(
	[UserAccount_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaymentId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_PaymentId] ON [dbo].[Transaction]
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserPaymentId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserPaymentId] ON [dbo].[Transaction]
(
	[UserPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_EmailAddress]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EmailAddress] ON [dbo].[UserAccount]
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TeamWorkId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TeamWorkId] ON [dbo].[UserAccount]
(
	[TeamWorkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaymentId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_PaymentId] ON [dbo].[UserPayment]
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[UserPayment]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PaymentMethodId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_PaymentMethodId] ON [dbo].[UserPaymentMethods]
(
	[PaymentMethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserAccountId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserAccountId] ON [dbo].[UserPaymentMethods]
(
	[UserAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[UserRole]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserAccountId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserAccountId] ON [dbo].[UserRole]
(
	[UserAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ConfirmedNotificationMessageId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_ConfirmedNotificationMessageId] ON [dbo].[Vacation]
(
	[ConfirmedNotificationMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[Vacation]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserId]    Script Date: 10/6/2016 10:36:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[VacationInitialDays]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TimeEntry] ADD  DEFAULT ('1900-01-01T00:00:00.000') FOR [CreateDate]
GO
ALTER TABLE [dbo].[TimeEntry] ADD  DEFAULT ('1900-01-01T00:00:00.000') FOR [ModDate]
GO
ALTER TABLE [dbo].[TimeEntry] ADD  DEFAULT ((0)) FOR [ModBy]
GO
ALTER TABLE [dbo].[TimeEntry] ADD  DEFAULT ((0)) FOR [CreateBy]
GO
ALTER TABLE [dbo].[AuditTrailRecord]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AuditTrailRecord_dbo.UserAccount_UserAccountId] FOREIGN KEY([UserAccountId])
REFERENCES [dbo].[UserAccount] ([Id])
GO
ALTER TABLE [dbo].[AuditTrailRecord] CHECK CONSTRAINT [FK_dbo.AuditTrailRecord_dbo.UserAccount_UserAccountId]
GO
ALTER TABLE [dbo].[CashMethods]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CashMethods_dbo.UserPaymentMethods_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[UserPaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[CashMethods] CHECK CONSTRAINT [FK_dbo.CashMethods_dbo.UserPaymentMethods_Id]
GO
ALTER TABLE [dbo].[CreditCards]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CreditCards_dbo.UserPaymentMethods_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[UserPaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[CreditCards] CHECK CONSTRAINT [FK_dbo.CreditCards_dbo.UserPaymentMethods_Id]
GO
ALTER TABLE [dbo].[CustomerInvoiceCurrency]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CustomerInvoiceCurrency_dbo.CustomerInvoice_CustomerInvoiceId] FOREIGN KEY([CustomerInvoiceId])
REFERENCES [dbo].[CustomerInvoice] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerInvoiceCurrency] CHECK CONSTRAINT [FK_dbo.CustomerInvoiceCurrency_dbo.CustomerInvoice_CustomerInvoiceId]
GO
ALTER TABLE [dbo].[CustomerInvoiceFields]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CustomerInvoiceFields_dbo.CustomerInvoice_CustomerInvoiceId] FOREIGN KEY([CustomerInvoiceId])
REFERENCES [dbo].[CustomerInvoice] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerInvoiceFields] CHECK CONSTRAINT [FK_dbo.CustomerInvoiceFields_dbo.CustomerInvoice_CustomerInvoiceId]
GO
ALTER TABLE [dbo].[CustomerInvoiceLineItem]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CustomerInvoiceLineItem_dbo.CustomerInvoice_CustomerInvoiceId] FOREIGN KEY([CustomerInvoiceId])
REFERENCES [dbo].[CustomerInvoice] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerInvoiceLineItem] CHECK CONSTRAINT [FK_dbo.CustomerInvoiceLineItem_dbo.CustomerInvoice_CustomerInvoiceId]
GO
ALTER TABLE [dbo].[CustomerInvoicePayment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CustomerInvoicePayment_dbo.CustomerInvoice_CustomerInvoiceId] FOREIGN KEY([CustomerInvoiceId])
REFERENCES [dbo].[CustomerInvoice] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerInvoicePayment] CHECK CONSTRAINT [FK_dbo.CustomerInvoicePayment_dbo.CustomerInvoice_CustomerInvoiceId]
GO
ALTER TABLE [dbo].[CustomerInvoiceTemplate]  WITH CHECK ADD  CONSTRAINT [FK_dbo.CustomerInvoiceTemplate_dbo.CustomerInvoice_CustomerInvoiceId] FOREIGN KEY([CustomerInvoiceId])
REFERENCES [dbo].[CustomerInvoice] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerInvoiceTemplate] CHECK CONSTRAINT [FK_dbo.CustomerInvoiceTemplate_dbo.CustomerInvoice_CustomerInvoiceId]
GO
ALTER TABLE [dbo].[InvoiceItem]  WITH CHECK ADD  CONSTRAINT [FK_dbo.InvoiceItem_dbo.InvoiceHeader_InvoiceId] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[InvoiceHeader] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InvoiceItem] CHECK CONSTRAINT [FK_dbo.InvoiceItem_dbo.InvoiceHeader_InvoiceId]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Project_dbo.Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_dbo.Project_dbo.Customer_CustomerId]
GO
ALTER TABLE [dbo].[ProjectUserAccount]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserToProject_dbo.Project_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectUserAccount] CHECK CONSTRAINT [FK_dbo.UserToProject_dbo.Project_ProjectId]
GO
ALTER TABLE [dbo].[ProjectUserAccount]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserToProject_dbo.UserAccount_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectUserAccount] CHECK CONSTRAINT [FK_dbo.UserToProject_dbo.UserAccount_UserId]
GO
ALTER TABLE [dbo].[SalaryRate]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SalaryRate_dbo.UserAccount_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SalaryRate] CHECK CONSTRAINT [FK_dbo.SalaryRate_dbo.UserAccount_UserId]
GO
ALTER TABLE [dbo].[SalesProject]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SalesProject_dbo.Project_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
GO
ALTER TABLE [dbo].[SalesProject] CHECK CONSTRAINT [FK_dbo.SalesProject_dbo.Project_ProjectId]
GO
ALTER TABLE [dbo].[SalesProject]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SalesProject_dbo.UserAccount_SalesManagerId] FOREIGN KEY([SalesManagerId])
REFERENCES [dbo].[UserAccount] ([Id])
GO
ALTER TABLE [dbo].[SalesProject] CHECK CONSTRAINT [FK_dbo.SalesProject_dbo.UserAccount_SalesManagerId]
GO
ALTER TABLE [dbo].[SalesTransaction]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SalesTransaction_dbo.SalesProject_ProjectId] FOREIGN KEY([SalesProjectId])
REFERENCES [dbo].[SalesProject] ([Id])
GO
ALTER TABLE [dbo].[SalesTransaction] CHECK CONSTRAINT [FK_dbo.SalesTransaction_dbo.SalesProject_ProjectId]
GO
ALTER TABLE [dbo].[SalesTransaction]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SalesTransaction_dbo.Transaction_TransactionId] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transaction] ([Id])
GO
ALTER TABLE [dbo].[SalesTransaction] CHECK CONSTRAINT [FK_dbo.SalesTransaction_dbo.Transaction_TransactionId]
GO
ALTER TABLE [dbo].[SkrillAccounts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SkrillAccounts_dbo.UserPaymentMethods_Id] FOREIGN KEY([Id])
REFERENCES [dbo].[UserPaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[SkrillAccounts] CHECK CONSTRAINT [FK_dbo.SkrillAccounts_dbo.UserPaymentMethods_Id]
GO
ALTER TABLE [dbo].[TimeEntry]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TimeEntry_dbo.UserAccount_UserAccount_Id] FOREIGN KEY([UserAccount_Id])
REFERENCES [dbo].[UserAccount] ([Id])
GO
ALTER TABLE [dbo].[TimeEntry] CHECK CONSTRAINT [FK_dbo.TimeEntry_dbo.UserAccount_UserAccount_Id]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Transaction_dbo.Payment_PaymentId] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_dbo.Transaction_dbo.Payment_PaymentId]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Transaction_dbo.UserPayment_UserPaymentId] FOREIGN KEY([UserPaymentId])
REFERENCES [dbo].[UserPayment] ([Id])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_dbo.Transaction_dbo.UserPayment_UserPaymentId]
GO
ALTER TABLE [dbo].[UserAccount]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserAccount_dbo.UserPaymentMethods_DefaultPaymentMethodId] FOREIGN KEY([DefaultPaymentMethodId])
REFERENCES [dbo].[UserPaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[UserAccount] CHECK CONSTRAINT [FK_dbo.UserAccount_dbo.UserPaymentMethods_DefaultPaymentMethodId]
GO
ALTER TABLE [dbo].[UserPayment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserPayment_dbo.Payment_UserPaymentId] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPayment] CHECK CONSTRAINT [FK_dbo.UserPayment_dbo.Payment_UserPaymentId]
GO
ALTER TABLE [dbo].[UserPayment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserPayment_dbo.UserAccount_UserAccountId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([Id])
GO
ALTER TABLE [dbo].[UserPayment] CHECK CONSTRAINT [FK_dbo.UserPayment_dbo.UserAccount_UserAccountId]
GO
ALTER TABLE [dbo].[UserPaymentMethods]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserPaymentMethods_dbo.PaymentMethods_PaymentMethodId] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[PaymentMethods] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPaymentMethods] CHECK CONSTRAINT [FK_dbo.UserPaymentMethods_dbo.PaymentMethods_PaymentMethodId]
GO
ALTER TABLE [dbo].[UserPaymentMethods]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserPaymentMethods_dbo.UserAccount_UserAccountId] FOREIGN KEY([UserAccountId])
REFERENCES [dbo].[UserAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPaymentMethods] CHECK CONSTRAINT [FK_dbo.UserPaymentMethods_dbo.UserAccount_UserAccountId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.UserAccount_UserAccountId] FOREIGN KEY([UserAccountId])
REFERENCES [dbo].[UserAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.UserAccount_UserAccountId]
GO
ALTER TABLE [dbo].[Vacation]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Vacation_dbo.PostponedMessage_ConfirmedNotificationMessageId] FOREIGN KEY([ConfirmedNotificationMessageId])
REFERENCES [dbo].[PostponedMessage] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Vacation] CHECK CONSTRAINT [FK_dbo.Vacation_dbo.PostponedMessage_ConfirmedNotificationMessageId]
GO
ALTER TABLE [dbo].[Vacation]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Vacation_dbo.UserAccount_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Vacation] CHECK CONSTRAINT [FK_dbo.Vacation_dbo.UserAccount_UserId]
GO
ALTER TABLE [dbo].[VacationInitialDays]  WITH CHECK ADD  CONSTRAINT [FK_dbo.VacationInitialDays_dbo.UserAccount_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VacationInitialDays] CHECK CONSTRAINT [FK_dbo.VacationInitialDays_dbo.UserAccount_UserId]
GO
USE [master]
GO
ALTER DATABASE [Empeek] SET  READ_WRITE 
GO
