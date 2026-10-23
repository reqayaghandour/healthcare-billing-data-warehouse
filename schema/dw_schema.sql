-- Data warehouse (star schema) for billing performance
CREATE DATABASE IF NOT EXISTS healthcare_clinic_dw;
USE healthcare_clinic_dw;

CREATE TABLE Dimension_Patient (
    PatientKey  INT          NOT NULL,
    PatientID   INT,
    FirstName   VARCHAR(50),
    LastName    VARCHAR(50),
    Email       VARCHAR(100),
    PRIMARY KEY (PatientKey)
);

CREATE TABLE Dimension_Doctor (
    DoctorKey       INT          NOT NULL,
    DoctorID        INT,
    DoctorName      VARCHAR(100),
    Specialization  VARCHAR(100),
    DoctorContact   VARCHAR(100),
    PRIMARY KEY (DoctorKey)
);

CREATE TABLE Dimension_Time (
    TimeKey    INT          NOT NULL,
    FullDate   DATE,
    Day        INT,
    Month      INT,
    Quarter    INT,
    Year       INT,
    MonthName  VARCHAR(20),
    PRIMARY KEY (TimeKey)
);

CREATE TABLE Dimension_BillingItem (
    BillingItemKey  INT          NOT NULL,
    BillingItem     VARCHAR(100),
    PRIMARY KEY (BillingItemKey)
);

CREATE TABLE Dimension_Procedure (
    ProcedureKey   INT          NOT NULL,
    ProcedureID    INT,
    ProcedureName  VARCHAR(100),
    PRIMARY KEY (ProcedureKey)
);

CREATE TABLE Fact_BillingPerformance (
    BillingPerformanceKey               INT            NOT NULL,
    InvoiceID                           INT,
    AppointmentID                       INT,
    Amount                              DECIMAL(10,2),
    AppointmentCount                    INT,
    BillingCount                        INT,
    Dimension_Time_TimeKey              INT            NOT NULL,
    Dimension_BillingItem_BillingItemKey INT           NOT NULL,
    Dimension_Procedure_ProcedureKey    INT            NOT NULL,
    Dimension_Doctor_DoctorKey          INT            NOT NULL,
    Dimension_Patient_PatientKey        INT            NOT NULL,
    PRIMARY KEY (BillingPerformanceKey),
    FOREIGN KEY (Dimension_Time_TimeKey)               REFERENCES Dimension_Time (TimeKey),
    FOREIGN KEY (Dimension_BillingItem_BillingItemKey) REFERENCES Dimension_BillingItem (BillingItemKey),
    FOREIGN KEY (Dimension_Procedure_ProcedureKey)     REFERENCES Dimension_Procedure (ProcedureKey),
    FOREIGN KEY (Dimension_Doctor_DoctorKey)           REFERENCES Dimension_Doctor (DoctorKey),
    FOREIGN KEY (Dimension_Patient_PatientKey)         REFERENCES Dimension_Patient (PatientKey)
);
