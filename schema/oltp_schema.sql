-- Source (OLTP) database for the healthcare clinic network
CREATE DATABASE IF NOT EXISTS healthcare_clinic_oltp;
USE healthcare_clinic_oltp;

CREATE TABLE Patient (
    PatientID   INT          NOT NULL,
    FirstName   VARCHAR(50),
    LastName    VARCHAR(50),
    Email       VARCHAR(100),
    PRIMARY KEY (PatientID)
);

CREATE TABLE Doctor (
    DoctorID        INT          NOT NULL,
    DoctorName      VARCHAR(100),
    Specialization  VARCHAR(100),
    DoctorContact   VARCHAR(100),
    PRIMARY KEY (DoctorID)
);

CREATE TABLE Appointment (
    AppointmentID      INT        NOT NULL,
    AppointmentDate    DATE,
    AppointmentTime    VARCHAR(8),
    Patient_PatientID  INT        NOT NULL,
    Doctor_DoctorID    INT        NOT NULL,
    PRIMARY KEY (AppointmentID),
    FOREIGN KEY (Patient_PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (Doctor_DoctorID)   REFERENCES Doctor (DoctorID)
);

CREATE TABLE MedicalProcedure (
    ProcedureID                INT          NOT NULL,
    ProcedureName              VARCHAR(100),
    Appointment_AppointmentID  INT          NOT NULL,
    PRIMARY KEY (ProcedureID),
    FOREIGN KEY (Appointment_AppointmentID) REFERENCES Appointment (AppointmentID)
);

CREATE TABLE Billing (
    InvoiceID                  INT            NOT NULL,
    BillingItem                VARCHAR(100),
    Amount                     DECIMAL(10,2),
    Appointment_AppointmentID  INT            NOT NULL,
    Patient_PatientID          INT            NOT NULL,
    PRIMARY KEY (InvoiceID),
    FOREIGN KEY (Appointment_AppointmentID) REFERENCES Appointment (AppointmentID),
    FOREIGN KEY (Patient_PatientID)         REFERENCES Patient (PatientID)
);

-- Load order: Patient -> Doctor -> Appointment -> MedicalProcedure -> Billing
