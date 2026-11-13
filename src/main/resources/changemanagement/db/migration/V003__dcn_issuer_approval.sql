-- Existing DCNs retain their IDs and numbers. New identity fields are nullable
-- because historical records predate issuer/approval tracking.
ALTER TABLE design_change_notice ADD COLUMN issued_by VARCHAR(255);
ALTER TABLE design_change_notice ADD COLUMN approved_by VARCHAR(255);
ALTER TABLE design_change_notice ADD COLUMN approved_at TIMESTAMP;
