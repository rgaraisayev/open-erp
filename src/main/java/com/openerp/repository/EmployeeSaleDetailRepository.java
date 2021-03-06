package com.openerp.repository;

import com.openerp.entity.Employee;
import com.openerp.entity.EmployeeSaleDetail;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EmployeeSaleDetailRepository extends JpaRepository<EmployeeSaleDetail, Integer> {
    List<EmployeeSaleDetail> getEmployeeSaleDetailsByEmployee_Id(Integer id);
    EmployeeSaleDetail getEmployeeSaleDetailByEmployeeAndKey(Employee employee, String key);
}