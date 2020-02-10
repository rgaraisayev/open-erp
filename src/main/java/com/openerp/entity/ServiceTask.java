package com.openerp.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "sale_service_task")
@Getter
@Setter
@NoArgsConstructor
public class ServiceTask {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO, generator = "sale_service_task_sequence")
    @SequenceGenerator(sequenceName = "aa_sale_service_task_sequence", initialValue = 1, allocationSize = 1, name = "sale_service_task_sequence")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "sale_sales_id")
    private Sales sales;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hr_organization_id", nullable = false)
    private Organization organization;

    @OneToMany(mappedBy = "serviceTask", cascade = CascadeType.ALL)
    private List<ServiceRegulatorTask> serviceRegulatorTasks;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    @Column(name = "task_date")
    private Date taskDate;

    @Transient
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date taskDateFrom;

    @Pattern(regexp = "(.{3,500})", message="Minimum 3 maksimum 500 simvol ola bilər")
    @Column(name = "description", nullable = false)
    private String description;

    public ServiceTask(Organization organization) {
        this.organization = organization;
    }
}