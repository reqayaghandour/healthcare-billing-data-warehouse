-- Reporting view: revenue and appointment totals by specialization, procedure and month
CREATE VIEW vw_BillingPerformanceSummary AS
SELECT
    d.Specialization,
    p.ProcedureName,
    t.Month,
    t.Year,
    SUM(f.Amount)           AS TotalRevenue,
    SUM(f.AppointmentCount) AS TotalAppointments
FROM Fact_BillingPerformance f
JOIN Dimension_Doctor d
    ON f.Dimension_Doctor_DoctorKey = d.DoctorKey
JOIN Dimension_Procedure p
    ON f.Dimension_Procedure_ProcedureKey = p.ProcedureKey
JOIN Dimension_Time t
    ON f.Dimension_Time_TimeKey = t.TimeKey
WHERE f.Amount > 0
GROUP BY d.Specialization, p.ProcedureName, t.Month, t.Year
ORDER BY TotalRevenue DESC;

-- Example
SELECT * FROM healthcare_clinic_dw.vw_BillingPerformanceSummary LIMIT 20;
