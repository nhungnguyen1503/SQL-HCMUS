USE QLDT
GO
--j--
CREATE PROCEDURE spXuatDSGiaoVien
AS
	SELECT * FROM GIAOVIEN

Exec spXuatDSGiaoVien
GO

--k--
CREATE PROCEDURE spTinhSLDeTai
AS
	SELECT COUNT(DISTINCT TGDT.MADT)
	FROM GIAOVIEN GV
	LEFT JOIN THAMGIADT TGDT
	ON GV.MAGV = TGDT.MAGV
	GROUP BY GV.MAGV
Exec spTinhSLDeTai
GO

--l--
CREATE PROCEDURE spInThongTinGV
AS
	SELECT GV1.*, SLDT, SLNT
	FROM (SELECT GV.MAGV, COUNT(DISTINCT TGDT.MADT) SLDT, COUNT(DISTINCT NT.TEN) SLNT
	FROM GIAOVIEN GV
	LEFT JOIN THAMGIADT TGDT
	ON GV.MAGV = TGDT.MAGV
	LEFT JOIN NGUOITHAN NT
	ON GV.MAGV = NT.MAGV
	GROUP BY GV.MAGV) AS T
	JOIN GIAOVIEN GV1
	ON T.MAGV = GV1.MAGV
Exec spInThongTinGV
GO

--m--
CREATE PROCEDURE spKiemTraGVTonTai @MaGV char(3)
AS
IF ( EXISTS (SELECT * FROM GIAOVIEN WHERE MAGV=@MAGV) )
Print N'Giáo viên tồn tại'
ELSE
Print N'Không tồn tại giáo viên !' + @MaGV

Exec spKiemTraGVTonTai '001'
GO

--n--
CREATE PROCEDURE spKiemTraTGDT @MaGV char(3)
AS
	IF((SELECT MADT FROM THAMGIADT WHERE MAGV = @MaGV) = (SELECT MADT FROM DETAI WHERE GVCNDT = @MaGV))
		PRINT N'Giáo viên được thực hiện đề tài'
	ELSE
		PRINT N'Giáo viên không được thực hiện đề tài'

Exec spKiemTraTGDT '001'
GO

--o--
CREATE PROCEDURE spPhanCongTGDT @MaGV char(3), @TenCV nvarchar(40)
AS
	IF(EXISTS(SELECT *
			FROM GIAOVIEN
			WHERE MAGV = @MaGV) AND EXISTS(SELECT *
											FROM CONGVIEC
											WHERE TENCV = @TenCV) AND (SELECT DATEDIFF(DAY, NGAYKT, NGAYBD)
																		FROM CONGVIEC
																		WHERE TENCV = @TenCV) > 0 AND (SELECT MADT FROM THAMGIADT WHERE MAGV = @MaGV) = (SELECT MADT FROM DETAI WHERE GVCNDT = @MaGV))
	PRINT N'Có thể phân công công việc này'
	ELSE
	PRINT N'Không thể phân công công việc này'

Exec spPhanCongTGDT '001', N'Xác định yêu cầu'
GO

--p--
CREATE PROCEDURE spXoaGV @MaGV char(3)
AS
	IF(@MaGV IN(SELECT MAGV FROM THAMGIADT) AND @MaGV IN(SELECT MAGV FROM NGUOITHAN))
	PRINT N'Không thể xóa'
	ELSE
	BEGIN
	DELETE GIAOVIEN WHERE MAGV = @MaGV
	PRINT N'Đã xóa giáo viên'
	END

Exec spXoaGV '001'
GO

--q--
CREATE PROCEDURE spInTheoMaKhoa @MaKhoa char(3)
AS
	SELECT GV1.*, SLDT, SLNT, SLGV
	FROM (SELECT GV.MAGV, COUNT(DISTINCT TGDT.MADT) SLDT, COUNT(DISTINCT NT.TEN) SLNT, COUNT(DISTINCT QL.MAGV) SLGV
	FROM GIAOVIEN GV
	LEFT JOIN THAMGIADT TGDT
	ON GV.MAGV = TGDT.MAGV
	LEFT JOIN NGUOITHAN NT
	ON GV.MAGV = NT.MAGV
	LEFT JOIN GIAOVIEN QL
	ON GV.MAGV = QL.GVQLCM
	GROUP BY GV.MAGV) AS T
	JOIN GIAOVIEN GV1
	ON T.MAGV = GV1.MAGV
	JOIN BOMON BM
	ON GV1.MABM = BM.MABM
	WHERE BM.MAKHOA = @MaKhoa

Exec spInTheoMaKhoa '001'
GO

--r--
CREATE PROCEDURE spKiemTraLuong @MaGVA char(3), @MaGVB char(3)
AS
	IF((SELECT MABM FROM BOMON WHERE TRUONGBM = @MaGVA) = (SELECT MABM FROM GIAOVIEN WHERE MAGV = @MaGVB))
	BEGIN
		IF((SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGVA) > (SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGVB))
		PRINT N'Đúng'
		ELSE
		PRINT N'Sai'
	END
	ELSE
	PRINT N'Sai'

Exec spKiemTraLuong '001', '002'
GO

--s--
CREATE PROCEDURE spThemGV @MaGV char(3), @HoTen nvarchar(40), @Luong FLOAT, @Phai nvarchar(10), @NgSinh DATE, @DiaChi nvarchar(40), @GVQLCM char(3) , @MaBM char(3)
AS
	IF(@HoTen NOT IN(SELECT HOTEN FROM GIAOVIEN) AND DATEDIFF(YEAR, GETDATE(), @NgSinh) > 18 AND @Luong > 0)
	BEGIN
	INSERT GIAOVIEN
	VALUES
		(@MaGV, @HoTen, @Luong, @Phai, @NgSinh, @DiaChi, @GVQLCM, @MaBM)
	END
GO

--t--
CREATE PROCEDURE spTuDongHoaMaGV
AS
	Declare @MaGV char(3)
	Set @MaGV = '001'
	WHILE(@MaGV IN (SELECT MAGV FROM GIAOVIEN))
	BEGIN
	Set @MaGV = FORMAT(@MaGV + 1, '000')
	END
	PRINT @MaGV
Exec spTuDongHoaMaGV
GO