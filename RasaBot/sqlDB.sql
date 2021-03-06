USE [master]
GO
/****** Object:  Database [OnlineShop]    Script Date: 02/08/2021 1:35:20 SA ******/
CREATE DATABASE [OnlineShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\OnlineShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\OnlineShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [OnlineShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [OnlineShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineShop] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineShop] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlineShop', N'ON'
GO
ALTER DATABASE [OnlineShop] SET QUERY_STORE = OFF
GO
USE [OnlineShop]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 02/08/2021 1:35:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](250) NULL,
	[age] [int] NULL,
	[phoneNumber] [nvarchar](50) NOT NULL,
	[gender] [bit] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_Receipt]    Script Date: 02/08/2021 1:35:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Receipt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_receipt] [int] NOT NULL,
	[id_product] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [PK_Detail_Receipt] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 02/08/2021 1:35:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[price] [float] NOT NULL,
	[effects] [nvarchar](1000) NULL,
	[composition] [nvarchar](1000) NULL,
	[contraindications] [nvarchar](1000) NULL,
	[storage] [nvarchar](1000) NULL,
	[made_in] [nvarchar](1000) NULL,
	[recognizing_signs] [nvarchar](1000) NULL,
	[sale] [nvarchar](1000) NULL,
	[delivery] [nvarchar](1000) NULL,
	[user_object] [nvarchar](1000) NULL,
	[the_number_of_products] [nvarchar](100) NULL,
	[url_image] [nvarchar](200) NULL,
	[priceText] [nvarchar](200) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 02/08/2021 1:35:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_customer] [int] NOT NULL,
	[address] [nvarchar](1000) NULL,
	[date] [datetime] NULL,
	[note] [nvarchar](1000) NULL,
	[total] [float] NULL,
 CONSTRAINT [PK_Receipt] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Manual]    Script Date: 02/08/2021 1:35:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Manual](
	[id_product] [int] NOT NULL,
	[year_gr1] [nvarchar](1000) NULL,
	[year_gr2] [nvarchar](1000) NULL,
	[year_gr3] [nvarchar](1000) NULL,
 CONSTRAINT [PK_User_Manual] PRIMARY KEY CLUSTERED 
(
	[id_product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [price], [effects], [composition], [contraindications], [storage], [made_in], [recognizing_signs], [sale], [delivery], [user_object], [the_number_of_products], [url_image], [priceText]) VALUES (1, N'Bánh dinh dưỡng Hebi', 32000, N'👉 Hebi là thực phẩm cao năng lượng, thích hợp sử dụng để gói bánh Hebi có trọng lượng 92g nhưng có thể cung cấp 500kcalo cho cơ thể.
👉 Bổ sung năng lượng và các vi chất dinh dưỡng cần thiết cho sự phát triển của trẻ.
👉 Sản phẩm thích hợp để phòng ngừa suy dinh dưỡng và phục hồi sức khỏe.
Chú ý: Sản phẩm này không phải là thuốc và không có tác dụng thay thế thuốc chữa bệnh.', N'Đậu tương, đậu xanh, gạo, vừng, sữa bột, đạm whey, maltodextrin, đường kính, chất béo thực vật, dầu thực vật, vitamin A, vitamin C, vitamin D, vitamin E, vitamin K: 17 mcg, vitamin B1: 0,35 mg, vitamin B2: 1,7 mg , vitamin B3: 4,5 mg, vitamin B7: 36 mcg, vitamin B6: 0,6 mg, vitamin B12: 1,8 mcg, acid folic: 250 mcg, kali: 800 mg, canxi: 450 mg, phospho: 400 mg, magie: 90 mg, kẽm: 14 mg, đồng: 1 mg, iot: 100 mcg, selen: 25,3 mcg, sắt: 7 mg.', N'Một số lưu ý khi sử dụng sản phẩm:
⚠ Sử dụng trực tiếp (không cần trộn với nước trước khi sử dụng)
⚠ Tuổi từ 12-24 tháng tuổi: dùng theo chỉ định của bác sỹ dinh dưỡng
⚠ Trẻ em trên 24 tháng tuổi và người già, người mới ốm dậy có thể ăn 1-2 gói/ ngày theo nhu cầu năng lượng của cơ thể.', N'👉 Bảo quản sản phẩm nơi khô ráo, thoáng mát tránh ánh sáng. Gói chưa sử dụng hết được đậy kín, để nơi khô, thoáng mát và dùng hết trong vòng 24h sau khi mở.
👉 Hạn sử dụng: 24 tháng kể từ ngày sản xuất', N'Sản phẩm do viện dinh dưỡng quốc gia Việt Nam sản xuất.', N'Sản phẩm rất dễ nhận biết với: 
👉 Dập khuân dạng viên
👉 Màu vàng tươi 
👉 Có mùi thơm đặc trưng của đậu', NULL, N'✅ 	GIAO HÀNG Toàn quốc- MIỄN PHÍ giao hàng nội thành Hà nội.
✅ 	NHẬN HÀNG > Khách hàng kiểm tra > KH. Thanh Toán.
✅ ĐỔI trả hàng trong vòng 07 ngày.
Thời gian giao hàng tùy thuộc vào vị trí của bạn', N'Sản phẩm dành cho:
👉 Trẻ em trên 01 tuổi bị suy dinh dưỡng cấp tính.
👉 Trẻ em bị bệnh hoặc cần phục hồi sức khỏe sau thời gian bệnh.
👉 Người già, người mới ốm dậy, người bị suy nhược hoặc người bệnh sau phẫu thuật.', N'Một gói bánh có 8 miếng', NULL, N'Sản phẩm có giá 320k/10 gói ✅ (Một gói bánh có 8 miếng)')
INSERT [dbo].[Product] ([id], [name], [price], [effects], [composition], [contraindications], [storage], [made_in], [recognizing_signs], [sale], [delivery], [user_object], [the_number_of_products], [url_image], [priceText]) VALUES (2, N'Men vi khuẩn sống Việt Nhật
', 150000, N'👉 Giúp bổ sung vi khuẩn có lợi, giúp phòng ngừa rối loạn tiêu hóa
👉 Hỗ trợ cân bằng lại hệ vi sinh đường ruột, tăng khả năng hấp thụ chất dinh dưỡng ở đường ruột
👉 Giúp giảm các triệu chứng tiêu hóa như: đầy bụng, khó tiêu, phân sống, táo bón, tiểu chảy ở trẻ em và người lớn.
👉 Cải thiện tình trạng rối loạn tiêu hóa (loạn khuẩn) ở trẻ nhỏ
👉 Giảm tác dụng phụ khi trẻ phải sử dụng kháng sinh
👉 Tăng cường khả năng miễn dịch của trẻ nhỏ
👉 Đẩy lùi các chứng bệnh viêm đại tràng cấp và mạn tính, ung thư đại trang ở người lớn.
👉 Dùng tốt cho các trường hợp ăn uống bị đầy hơi khó tiêu, ngộ độc thức ăn, hay uống rượu bia nhiêu, thở ra hơi thở có mùi hôi do bệnh dạ dày."
', N'"Sản phẩm gồm có:
👉 Lactobacillus acidophilus 10ˆ8 CFU 
👉 Bacillus subtilis 10ˆ8 CFU
👉 Enterococus faecium 10ˆ8 CFU
👉 Phụ liệu: nước vừa đủ 10ml
"
', N'"Một số lưu ý khi sử dụng sản phẩm:
⚠ Nếu quá 6 tháng trẻ chưa tẩy giun thì trước khi uống Men vi khuẩn sống Bạch Mai, nên tẩy giun cho trẻ.
⚠ Dung dịch men vi sinh sống sẽ có mùi đặc trưng của quá trình lên men
⚠ Uống sau khi ăn no từ 15-20 phút để có được hiệu quả tốt nhất
⚠ Nên để sản phẩm vào ngăn mát tủ lạnh để kéo dài hạn sử dụng
⚠ Với người bị viêm đại tràng nên sử dụng liên tục trên 1 tháng để có hiệu quả tốt nhất
⚠ Bỏ ra ngoài ngăn mát 15-20 phút trước khi sử dụng đối với trẻ sơ sinh"
', N'"👉 Nên để sản phẩm vào ngăn mát tủ lạnh để kéo dài hạn sử dụng
👉 Thời hạn bảo quản ở nhiệt độ phòng: 60 ngày
👉 Thời hạn bảo quản ở ngăn mát tủ lạnh: 6-8 tháng
Kể từ ngày sản xuất."
', N'"Men vi khuẩn sống Việt Nhật do Công Ty Cổ Phần dược phẩm Santex sản xuất
Được phân phối và chịu trách nhiệm về chất lượng sản phẩm bới CT Cổ phản Sinh học y dược Việt Nhật"
', N' Sản phẩm được đóng trong ống (lọ) nhựa PET / thủy tinh, hộp giấy bên ngoài bảo vệ sinh an toàn thực phẩm theo quy định của Bộ Y Tế.
', NULL, N'✅  GIAO HÀNG Toàn quốc- MIỄN PHÍ giao hàng nội thành Hà nội.
✅  NHẬN HÀNG > Khách hàng kiểm tra > KH. Thanh Toán.
✅ ĐỔI trả hàng trong vòng 07 ngày.
Thời gian giao hàng tùy thuộc vào vị trí của bạn"
', N'"Sản phẩm dành cho:
👉 Trẻ em và người lớn bị rối loạn tiêu hóa, ăn uống kém., trẻ biếng ăn do dùng nhiều kháng sinh.
👉 Người bị đầy hơi, khó tiêu, táo bón, tiêu chảy, phân sống do loạn khuẩn đường ruột và dùng kháng sinh kéo dài. Người đang trong giai đoạn phục hồi bệnh."
', N'/1 hộp 20 ống ( mỗi ống 10ml) ✅', NULL, N'Sản phẩm có giá  150k/1 hộp 20 ống ( mỗi ống 10ml) ✅')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
GO
INSERT [dbo].[User_Manual] ([id_product], [year_gr1], [year_gr2], [year_gr3]) VALUES (1, N'Trẻ dưới 2 tuối mỗi ngày bổ sung thêm khoảng 3 miếng ăn chia trong ngày. Có thể bóp ra pha với sữa hoặc quấy cùng cháo. Nếu bé ăn được có thể ăn trực tiếp luôn', N'Trẻ từ 2-15 tuổi mỗi ngày bổ sung khoảng 6-8 miếng (mỗi gói bánh có 8 miếng).
Cho bé ăn vào các bữa phụ cách xa bữa chính để bé không bỏ bữa', N'Người già, người lớn, người mới ốm dậy có thể ăn 01 – 02 gói/ ngày
 theo nhu cầu năng lượng của cơ thể.')
INSERT [dbo].[User_Manual] ([id_product], [year_gr1], [year_gr2], [year_gr3]) VALUES (2, N'Trẻ dưới 2 tuối dùng mỗi ngày 1 ống sau bữa ăn no. 
', N'Trẻ từ 2-15 tuổi có thể dùng 2 ống/ngày
', N'Người lớn dùng 4 ống/ ngày
')
GO
ALTER TABLE [dbo].[Detail_Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Receipt_Product] FOREIGN KEY([id_product])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Detail_Receipt] CHECK CONSTRAINT [FK_Detail_Receipt_Product]
GO
ALTER TABLE [dbo].[Detail_Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Receipt_Receipt] FOREIGN KEY([id_receipt])
REFERENCES [dbo].[Receipt] ([id])
GO
ALTER TABLE [dbo].[Detail_Receipt] CHECK CONSTRAINT [FK_Detail_Receipt_Receipt]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receipt_Customer] FOREIGN KEY([id_customer])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receipt_Customer]
GO
ALTER TABLE [dbo].[User_Manual]  WITH CHECK ADD  CONSTRAINT [FK_User_Manual_Product] FOREIGN KEY([id_product])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[User_Manual] CHECK CONSTRAINT [FK_User_Manual_Product]
GO
USE [master]
GO
ALTER DATABASE [OnlineShop] SET  READ_WRITE 
GO
