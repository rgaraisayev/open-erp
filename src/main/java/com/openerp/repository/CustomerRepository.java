package com.openerp.repository;

import com.openerp.entity.Customer;
import com.openerp.entity.Employee;
import com.openerp.entity.Organization;
import com.openerp.entity.Sales;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface CustomerRepository extends JpaRepository<Customer, Integer>, JpaSpecificationExecutor<Customer> {
    Customer getCustomerByIdAndActiveTrue(Integer id);
    Customer getCustomerById(Integer id);
    Customer getCustomerByIdAndActiveTrueAndOrganization(Integer id, Organization organization);
    List<Customer> getCustomersByActiveTrue();
    List<Customer> getCustomersByActiveTrueAndOrganization(Organization organization);
    List<Customer> getCustomersByPersonFirstNameStartingWithAndPersonLastNameStartingWithAndPersonFatherNameStartingWithAndOrganization(String firstName, String lastName, String fatherName, Organization organization);
    List<Customer> getCustomersByPersonFirstNameStartingWithAndPersonLastNameStartingWithAndOrganization(String firstName, String lastName, Organization organization);
}