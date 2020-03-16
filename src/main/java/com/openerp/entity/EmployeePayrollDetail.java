package com.openerp.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Entity
@Table(name = "hr_employee_payroll_detail")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class EmployeePayrollDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "hr_sequence")
    @SequenceGenerator(sequenceName = "aa_hr_sequence", allocationSize = 1, name = "hr_sequence")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @ToString.Exclude
    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hr_employee_id")
    private Employee employee;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "admin_dictionary_employee_payroll_field_id")
    private Dictionary employeePayrollField;

    @Column(name = "key_field")
    private String key;

    @Pattern(regexp=".{1,50}",message="Boş olmamalıdır")
    @Column(name = "value")
    private String value;

    public EmployeePayrollDetail(Employee employee, Dictionary employeePayrollField, String key, String value) {
        this.employee = employee;
        this.employeePayrollField = employeePayrollField;
        this.key = key;
        this.value = value;
    }
}
