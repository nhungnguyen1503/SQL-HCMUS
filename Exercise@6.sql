USE QLDT
GO

--Q58--
--EXCEPT
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE NOT EXISTS (
	(SELECT MADT FROM DETAI)
	EXCEPT
	(SELECT MADT
	FROM THAMGIADT TGDT2
	WHERE TGDT2.MAGV = TGDT1.MAGV)
)

--NOT EXISTS
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE NOT EXISTS (
	(SELECT * FROM DETAI DT
	WHERE NOT EXISTS
	(SELECT MADT
	FROM THAMGIADT TGDT2
	WHERE TGDT2.MAGV = TGDT1.MAGV AND DT.MADT = TGDT2.MADT)
	)
)

--COUNT
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
AND TGDT1.MADT IN (SELECT MADT FROM DETAI)
GROUP BY TGDT1.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT TGDT1.MADT) = (
	SELECT COUNT(MADT)
	FROM DETAI
)



--Q59--
--EXCEPT
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	WHERE GV.MABM = 'HTTT')
	EXCEPT
	(SELECT MAGV
	FROM THAMGIADT TGDT
	WHERE TGDT.MADT = DT.MADT
	)
)

--NOT EXISTS
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	WHERE GV.MABM = 'HTTT' AND NOT EXISTS
	(SELECT MAGV
	FROM THAMGIADT TGDT
	WHERE TGDT.MADT = DT.MADT AND GV.MAGV = TGDT.MAGV
	)
	)
)

--COUNT
SELECT DISTINCT DT.TENDT
FROM DETAI DT
JOIN THAMGIADT TGDT
ON DT.MADT = TGDT.MADT
WHERE TGDT.MAGV IN
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	WHERE GV.MABM = 'HTTT')
GROUP BY DT.MADT, DT.TENDT
HAVING COUNT(DISTINCT TGDT.MAGV) = (
	SELECT COUNT(GV.MAGV)
	FROM GIAOVIEN GV
	WHERE GV.MABM = 'HTTT'
)

--Q60--
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	JOIN BOMON BM
	ON GV.MABM= BM.MABM
	WHERE BM.TENBM = N'Hệ thống thông tin')
	EXCEPT
	(SELECT MAGV
	FROM THAMGIADT TGDT
	WHERE TGDT.MADT = DT.MADT
	)
)

--NOT EXISTS
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	JOIN BOMON BM
	ON GV.MABM= BM.MABM
	WHERE BM.TENBM = N'Hệ thống thông tin' AND NOT EXISTS
	(SELECT MAGV
	FROM THAMGIADT TGDT
	WHERE TGDT.MADT = DT.MADT AND GV.MAGV = TGDT.MAGV
	)
	)
)

--COUNT
SELECT DISTINCT DT.TENDT
FROM DETAI DT
JOIN THAMGIADT TGDT
ON DT.MADT = TGDT.MADT
WHERE TGDT.MAGV IN
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	JOIN BOMON BM
	ON GV.MABM= BM.MABM
	WHERE BM.TENBM = N'Hệ thống thông tin')
GROUP BY DT.MADT, DT.TENDT
HAVING COUNT(DISTINCT TGDT.MAGV) = (
	SELECT COUNT(GV.MAGV)
	FROM GIAOVIEN GV
	JOIN BOMON BM
	ON GV.MABM= BM.MABM
	WHERE BM.TENBM = N'Hệ thống thông tin'
)

--Q61--
--EXCEPT
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE NOT EXISTS (
	(SELECT MADT FROM DETAI WHERE MACD = 'QLGD')
	EXCEPT(
	SELECT MADT
	FROM THAMGIADT TGDT2
	WHERE TGDT1.MAGV = TGDT2.MAGV
	)
)

--NOT EXISTS
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE NOT EXISTS (
	(SELECT DT.MADT FROM DETAI DT WHERE DT.MACD = 'QLGD' AND NOT EXISTS (
	SELECT MADT
	FROM THAMGIADT TGDT2
	WHERE TGDT1.MAGV = TGDT2.MAGV AND TGDT2.MADT = DT.MADT
	)
	)
)

--COUNT
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE TGDT1.MADT IN
	(SELECT MADT FROM DETAI WHERE MACD = 'QLGD')
GROUP BY TGDT1.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT TGDT1.MADT) = (
	SELECT COUNT(DISTINCT MADT)
	FROM DETAI
	WHERE MACD = 'QLGD'
)

--Q62--
--EXCEPT
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE NOT EXISTS (
	(SELECT TGDT2.MADT
	FROM THAMGIADT TGDT2
	JOIN GIAOVIEN GV2
	ON TGDT2.MAGV = GV2.MAGV
	WHERE GV2.HOTEN = N'Trần Trà Hương')
	EXCEPT (
	SELECT TGDT3.MADT
	FROM THAMGIADT TGDT3
	WHERE TGDT1.MAGV = TGDT3.MAGV
	)
)

--NOT EXISTS
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV
WHERE NOT EXISTS (
	(SELECT *
	FROM THAMGIADT TGDT2
	JOIN GIAOVIEN GV2
	ON TGDT2.MAGV = GV2.MAGV
	WHERE GV2.HOTEN = N'Trần Trà Hương' AND NOT EXISTS (
	SELECT *
	FROM THAMGIADT TGDT3
	WHERE TGDT1.MAGV = TGDT3.MAGV AND TGDT3.MADT = TGDT2.MADT
	)
	)
)

--COUNT
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TGDT1
JOIN GIAOVIEN GV
ON TGDT1.MAGV = GV.MAGV AND TGDT1.MADT IN	(SELECT TGDT2.MADT
	FROM THAMGIADT TGDT2
	JOIN GIAOVIEN GV2
	ON TGDT2.MAGV = GV2.MAGV
	WHERE GV2.HOTEN = N'Trần Trà Hương')
GROUP BY TGDT1.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT TGDT1.MADT) =
(
	SELECT COUNT(DISTINCT TGDT2.MADT)
	FROM THAMGIADT TGDT2
	JOIN GIAOVIEN GV2
	ON TGDT2.MAGV = GV2.MAGV
	WHERE GV2.HOTEN = N'Trần Trà Hương')

--Q63--
--EXCEPT
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
(SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
WHERE BM.TENBM = N'Hóa hữu cơ'
) EXCEPT (
SELECT TGDT1.MAGV
FROM THAMGIADT TGDT1
WHERE TGDT1.MADT = DT.MADT
))

--NOT EXISTS
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
	(SELECT GV.MAGV
	FROM GIAOVIEN GV
	JOIN BOMON BM
	ON GV.MABM = BM.MABM
	WHERE BM.TENBM = N'Hóa hữu cơ'AND NOT EXISTS
	(SELECT TGDT.MAGV
	FROM THAMGIADT TGDT
	WHERE TGDT.MADT = DT.MADT AND TGDT.MAGV = GV.MAGV
	))
)

--COUNT
SELECT DISTINCT DT.TENDT
FROM DETAI DT
JOIN THAMGIADT TGDT
ON DT.MADT = TGDT.MADT
WHERE TGDT.MAGV IN
(SELECT GV.MAGV FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM = BM.MABM
WHERE BM.TENBM = N'Hóa hữu cơ')
GROUP BY DT.MADT, DT.TENDT
HAVING COUNT(DISTINCT TGDT.MAGV) = (
SELECT COUNT(DISTINCT GV1.MAGV)
FROM GIAOVIEN GV1
JOIN BOMON BM1 ON GV1.MABM = BM1.MABM
WHERE BM1.TENBM = N'Hóa hữu cơ'
)

--Q64--
--EXCEPT
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT CV.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV
ON TGDT.MADT = CV.MADT
WHERE TGDT.MADT = '006')
EXCEPT (
SELECT CV2.TENCV
FROM THAMGIADT TGDT2
JOIN CONGVIEC CV2
ON TGDT2.MADT = CV2.MADT
WHERE TGDT2.MAGV = GV.MAGV 
)
)

--NOT EXISTS
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT CV.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV
ON TGDT.MADT = CV.MADT
WHERE TGDT.MADT = '006' AND NOT EXISTS(
SELECT CV2.TENCV
FROM THAMGIADT TGDT2
JOIN CONGVIEC CV2
ON TGDT2.MADT = CV2.MADT
WHERE TGDT2.MAGV = GV.MAGV AND TGDT.MADT = TGDT2.MADT
))
)

--COUNT
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT
ON GV.MAGV = TGDT.MAGV
JOIN CONGVIEC CV
ON TGDT.MADT = CV.MADT
WHERE CV.TENCV IN (
SELECT CV.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV
ON TGDT.MADT = CV.MADT
WHERE TGDT.MADT = '006')
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT CV.TENCV) =
(SELECT COUNT(DISTINCT CV2.TENCV)
FROM THAMGIADT TGDT2
JOIN CONGVIEC CV2
ON TGDT2.MADT = CV2.MADT
WHERE TGDT2.MADT = '006')

--Q65--
--EXCEPT
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
JOIN CHUDE CD
ON DT.MACD = CD.MACD
WHERE CD.TENCD = N'Ứng dụng công nghệ')
EXCEPT
(SELECT DT1.MADT
FROM DETAI DT1
JOIN THAMGIADT TGDT
ON DT1.MADT = TGDT.MADT
WHERE TGDT.MAGV = GV.MAGV
))

--NOT EXISTS
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
JOIN CHUDE CD
ON DT.MACD = CD.MACD
WHERE CD.TENCD = N'Ứng dụng công nghệ' AND NOT EXISTS
(SELECT DT1.MADT
FROM DETAI DT1
JOIN THAMGIADT TGDT
ON DT1.MADT = TGDT.MADT
WHERE TGDT.MAGV = GV.MAGV AND TGDT.MADT = DT.MADT
)))

--COUNT
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT
ON GV.MAGV = TGDT.MAGV
WHERE TGDT.MADT IN (
SELECT DT.MADT
FROM DETAI DT
JOIN CHUDE CD
ON DT.MACD = CD.MACD
WHERE CD.TENCD = N'Ứng dụng công nghệ')
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT TGDT.MADT) = 
(
SELECT DT1.MADT
FROM DETAI DT1
JOIN CHUDE CD1
ON DT1.MACD = CD1.MACD
WHERE CD1.TENCD = N'Ứng dụng công nghệ'
)

--Q66--
--EXCEPT
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
JOIN GIAOVIEN GV1
ON DT.GVCNDT = GV1.MAGV
WHERE GV1.HOTEN = N'Trần Trà Hương'
)
EXCEPT 
(
SELECT TGDT.MADT
FROM THAMGIADT TGDT
WHERE TGDT.MAGV = GV.MAGV
))

--NOT EXISTS
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
JOIN GIAOVIEN GV1
ON DT.GVCNDT = GV1.MAGV
WHERE GV1.HOTEN = N'Trần Trà Hương' AND NOT EXISTS
(
SELECT TGDT.MADT
FROM THAMGIADT TGDT
WHERE TGDT.MAGV = GV.MAGV AND TGDT.MADT = DT.MADT
)))

--COUNT
SELECT *
FROM GIAOVIEN DSGV
WHERE DSGV.MAGV IN(
SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT
ON TGDT.MAGV = GV.MAGV
WHERE TGDT.MADT IN
(SELECT DT.MADT
FROM DETAI DT
JOIN GIAOVIEN GV1
ON DT.GVCNDT = GV1.MAGV
WHERE GV1.HOTEN = N'Trần Trà Hương'
)
GROUP BY GV.MAGV
HAVING COUNT(DISTINCT TGDT.MADT) =
(SELECT COUNT(DISTINCT DT1.MADT)
FROM DETAI DT1
JOIN GIAOVIEN GV2
ON DT1.GVCNDT = GV2.MAGV
WHERE GV2.HOTEN = N'Trần Trà Hương'
))

--Q67--
--EXCEPT
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
(SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
WHERE BM.MAKHOA = 'CNTT'
) EXCEPT (
SELECT TGDT1.MAGV
FROM THAMGIADT TGDT1
WHERE TGDT1.MADT = DT.MADT
))

--NOT EXISTS
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
(SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
WHERE BM.MAKHOA = 'CNTT' AND NOT EXISTS (
SELECT TGDT1.MAGV
FROM THAMGIADT TGDT1
WHERE TGDT1.MADT = DT.MADT AND TGDT1.MAGV = GV.MAGV
)))

--COUNT
SELECT DT.TENDT
FROM DETAI DT
JOIN THAMGIADT TGDT
ON DT.MADT = TGDT.MADT
WHERE TGDT.MAGV IN (
SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
WHERE BM.MAKHOA = 'CNTT'
)
GROUP BY DT.MADT, DT.TENDT
HAVING COUNT(DISTINCT TGDT.MAGV) = 
(
SELECT COUNT(DISTINCT GV1.MAGV)
FROM GIAOVIEN GV1
JOIN BOMON BM
ON BM.MABM = GV1.MABM
WHERE BM.MAKHOA = 'CNTT'
)

--Q68--
--EXCEPT
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT CV.TENCV
FROM CONGVIEC CV
JOIN DETAI DT
ON CV.MADT = DT.MADT
WHERE DT.TENDT = N'Nghiên cứu tế bào gốc'
) EXCEPT
(
SELECT CV2.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV2
ON TGDT.MADT = CV2.MADT
WHERE TGDT.MAGV = GV.MAGV
))

--NOT EXISTS
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
SELECT CV.TENCV
FROM CONGVIEC CV
JOIN DETAI DT
ON CV.MADT = DT.MADT
WHERE DT.TENDT = N'Nghiên cứu tế bào gốc' AND NOT EXISTS
(
SELECT CV2.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV2
ON TGDT.MADT = CV2.MADT
WHERE TGDT.MAGV = GV.MAGV AND CV2.TENCV = CV.TENCV
))

--COUNT
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT
ON GV.MAGV = TGDT.MAGV
JOIN CONGVIEC CV
ON CV.MADT = TGDT.MADT
WHERE CV.TENCV IN 
(SELECT CV1.TENCV
FROM CONGVIEC CV1
JOIN DETAI DT
ON CV1.MADT = DT.MADT
WHERE DT.TENDT = N'Nghiên cứu tế bào gốc'
)
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT CV.TENCV) = (
SELECT COUNT(DISTINCT CV2.TENCV)
FROM CONGVIEC CV2
JOIN DETAI DT1
ON CV2.MADT = DT1.MADT
WHERE DT1.TENDT = N'Nghiên cứu tế bào gốc'
)

--Q69--
--EXCEPT
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
WHERE DT.KINHPHI >100)
EXCEPT (
SELECT TGDT.MADT
FROM THAMGIADT TGDT
WHERE TGDT.MAGV = GV.MAGV
))

--NOT EXISTS
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS (
SELECT DT.MADT
FROM DETAI DT
WHERE DT.KINHPHI >100 AND NOT EXISTS 
(
SELECT TGDT.MADT
FROM THAMGIADT TGDT
WHERE TGDT.MAGV = GV.MAGV AND TGDT.MADT = DT.MADT
))

--COUNT
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT
ON TGDT.MAGV = GV.MAGV
WHERE TGDT.MADT IN (
SELECT DT.MADT
FROM DETAI DT
WHERE DT.KINHPHI >100)
GROUP BY GV.MAGV,GV.HOTEN
HAVING COUNT(DISTINCT TGDT.MADT) = 
(
SELECT COUNT(DISTINCT DT.MADT)
FROM DETAI DT
WHERE DT.KINHPHI >100
)

--Q70--
--EXCEPT
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
(SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
JOIN KHOA K
ON K.MAKHOA = BM.MAKHOA
WHERE K.TENKHOA = N'Sinh học'
) EXCEPT (
SELECT TGDT1.MAGV
FROM THAMGIADT TGDT1
WHERE TGDT1.MADT = DT.MADT
))

--NOT EXISTS
SELECT DISTINCT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (
SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
JOIN KHOA K
ON K.MAKHOA = BM.MAKHOA
WHERE K.TENKHOA = N'Sinh học' AND NOT EXISTS (
SELECT TGDT1.MAGV
FROM THAMGIADT TGDT1
WHERE TGDT1.MADT = DT.MADT AND TGDT1.MAGV = GV.MAGV
))

--COUNT
SELECT DT.TENDT
FROM DETAI DT
JOIN THAMGIADT TGDT
ON DT.MADT = TGDT.MADT
WHERE TGDT.MAGV IN (
SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
JOIN KHOA K
ON K.MAKHOA = BM.MAKHOA
WHERE K.TENKHOA = N'Sinh học'
)
GROUP BY DT.MADT, DT.TENDT
HAVING COUNT(DISTINCT TGDT.MAGV) = 
(
SELECT COUNT(DISTINCT GV1.MAGV)
FROM GIAOVIEN GV1
JOIN BOMON BM1
ON BM1.MABM = GV1.MABM
JOIN KHOA K1
ON K1.MAKHOA = BM1.MAKHOA
WHERE K1.TENKHOA = N'Sinh học'
)

--Q71--
--EXCEPT
SELECT GV.MAGV, GV.HOTEN, GV.NGSINH
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT CV.TENCV
FROM CONGVIEC CV
JOIN DETAI DT
ON CV.MADT = DT.MADT
WHERE DT.TENDT = N'Ứng dụng hóa học xanh'
) EXCEPT
(
SELECT CV2.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV2
ON TGDT.MADT = CV2.MADT
WHERE TGDT.MAGV = GV.MAGV
))

--NOT EXISTS
SELECT GV.MAGV, GV.HOTEN, GV.NGSINH
FROM GIAOVIEN GV
WHERE NOT EXISTS (
SELECT CV.TENCV
FROM CONGVIEC CV
JOIN DETAI DT
ON CV.MADT = DT.MADT
WHERE DT.TENDT = N'Ứng dụng hóa học xanh' AND NOT EXISTS
(
SELECT CV2.TENCV
FROM THAMGIADT TGDT
JOIN CONGVIEC CV2
ON TGDT.MADT = CV2.MADT
WHERE TGDT.MAGV = GV.MAGV AND CV2.TENCV = CV.TENCV
))

--COUNT
SELECT GV.MAGV, GV.HOTEN, GV.NGSINH
FROM GIAOVIEN GV
WHERE GV.MAGV IN (
SELECT GV.MAGV
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT
ON GV.MAGV = TGDT.MAGV
JOIN CONGVIEC CV
ON CV.MADT = TGDT.MADT
WHERE CV.TENCV IN 
(SELECT CV1.TENCV
FROM CONGVIEC CV1
JOIN DETAI DT
ON CV1.MADT = DT.MADT
WHERE DT.TENDT = N'Ứng dụng hóa học xanh'
)
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT CV.TENCV) = (
SELECT COUNT(DISTINCT CV2.TENCV)
FROM CONGVIEC CV2
JOIN DETAI DT1
ON CV2.MADT = DT1.MADT
WHERE DT1.TENDT = N'Ứng dụng hóa học xanh'
))

--Q72--
--EXCEPT
SELECT GV.MAGV, GV.HOTEN, BM.TENBM, (QL.HOTEN) TENQL
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
JOIN GIAOVIEN QL
ON QL.MAGV = GV.GVQLCM
WHERE GV.MAGV IN (
SELECT GV.MAGV
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
JOIN CHUDE CD
ON DT.MACD = CD.MACD
WHERE CD.TENCD = N'Nghiên cứu phát triển')
EXCEPT
(SELECT DT1.MADT
FROM DETAI DT1
JOIN THAMGIADT TGDT
ON DT1.MADT = TGDT.MADT
WHERE TGDT.MAGV = GV.MAGV
)))

--NOT EXISTS
SELECT GV.MAGV, GV.HOTEN, BM.TENBM, (QL.HOTEN) TENQL
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
JOIN GIAOVIEN QL
ON QL.MAGV = GV.GVQLCM
WHERE GV.MAGV IN(
SELECT GV.MAGV
FROM GIAOVIEN GV
WHERE NOT EXISTS (
(SELECT DT.MADT
FROM DETAI DT
JOIN CHUDE CD
ON DT.MACD = CD.MACD
WHERE CD.TENCD = N'Nghiên cứu phát triển' AND NOT EXISTS
(SELECT DT1.MADT
FROM DETAI DT1
JOIN THAMGIADT TGDT
ON DT1.MADT = TGDT.MADT
WHERE TGDT.MAGV = GV.MAGV AND TGDT.MADT = DT.MADT
))))

--COUNT
SELECT GV.MAGV, GV.HOTEN, BM.TENBM, (QL.HOTEN) TENQL
FROM GIAOVIEN GV
JOIN BOMON BM
ON BM.MABM = GV.MABM
JOIN GIAOVIEN QL
ON QL.MAGV = GV.GVQLCM
WHERE GV.MAGV IN(
	SELECT GV.MAGV
	FROM GIAOVIEN GV
	JOIN THAMGIADT TGDT
	ON GV.MAGV = TGDT.MAGV
	WHERE TGDT.MADT IN (
		SELECT DT.MADT
		FROM DETAI DT
		JOIN CHUDE CD
		ON DT.MACD = CD.MACD
	WHERE CD.TENCD = N'Nghiên cứu phát triển')
	GROUP BY GV.MAGV, GV.HOTEN
	HAVING COUNT(DISTINCT TGDT.MADT) = 
	(
		SELECT COUNT(DISTINCT DT1.MADT)
		FROM DETAI DT1
		JOIN CHUDE CD1
		ON DT1.MACD = CD1.MACD
		WHERE CD1.TENCD = N'Nghiên cứu phát triển'
	))