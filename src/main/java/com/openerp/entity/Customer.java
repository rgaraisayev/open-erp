package com.openerp.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Entity
@Table(name = "crm_customer")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Customer {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO, generator = "crm_customer_seq")
    @SequenceGenerator(sequenceName = "crm_customer_seq", allocationSize = 3, initialValue = 100001, name = "crm_customer_seq")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "person_id", nullable = false)
    private Person person;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "organization_id", nullable = false)
    private Organization organization;

    @Temporal(TemporalType.DATE)
    @Column(name = "contract_date")
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date contractDate = new Date();

    @Pattern(regexp=".{0,250}", message="Maksimum 250 simvol ola bilər")
    @Column(name = "description")
    private String description;

    @Column(name = "is_active", nullable = false, columnDefinition="boolean default true")
    private Boolean active = true;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", nullable = false)
    private Date createdDate = new Date();

    public Customer(Organization organization) {
        this.organization = organization;
    }

    public Customer(Integer id, Organization organization) {
        this.id = id;
        this.organization = organization;
    }
}
