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
import java.util.List;

@Entity
@Table(name = "vacation")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Vacation {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "vacation_seq")
    @SequenceGenerator(sequenceName = "vacation_seq", allocationSize = 1, name = "vacation_seq")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "organization_id", nullable = false)
    private Organization organization;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dictionary_identifier_id", nullable = false)
    private Dictionary identifier;

    @Temporal(TemporalType.DATE)
    @Column(name = "start_date")
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date startDate;

    @Temporal(TemporalType.DATE)
    @Column(name = "end_date")
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date endDate;

    @Pattern(regexp=".{15,25}",message="Minimum 15 maksimum 25 simvol ola bilər")
    @Column(name = "date_range", nullable = false)
    private String dateRange;

    @Pattern(regexp=".{0,250}",message="Maksimum 250 simvol ola bilər")
    @Column(name = "description")
    private String description;

    @ToString.Exclude
    @JsonIgnore
    @OneToMany(mappedBy = "vacation", cascade = CascadeType.ALL)
    private List<VacationDetail> vacationDetails;

    @Column(name = "is_active", nullable = false, columnDefinition="boolean default true")
    private Boolean active = true;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", nullable = false)
    private Date createdDate = new Date();

    public Vacation(Organization organization) {
        this.organization = organization;
    }

}
