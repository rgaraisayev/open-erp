package com.openerp.repository;

import com.openerp.entity.Employee;
import com.openerp.entity.WorkingHourRecordEmployee;
import com.openerp.entity.WorkingHourRecordEmployeeDayCalculation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WorkingHourRecordEmployeeDayCalculationRepository extends JpaRepository<WorkingHourRecordEmployeeDayCalculation, Integer> {
    List<WorkingHourRecordEmployeeDayCalculation> getWorkingHourRecordEmployeeDayCalculationsByWorkingHourRecordEmployee(WorkingHourRecordEmployee workingHourRecordEmployee);
    List<WorkingHourRecordEmployeeDayCalculation> getWorkingHourRecordEmployeeDayCalculationsByKeyAndWorkingHourRecordEmployee_EmployeeOrderByWorkingHourRecordEmployeeDesc(String key, Employee employee);
}