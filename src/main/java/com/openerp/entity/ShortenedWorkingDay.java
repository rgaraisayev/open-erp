package com.openerp.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Entity
@Table(name = "hr_shortened_working_day")
@Getter
@Setter
@NoArgsConstructor
public class ShortenedWorkingDay {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "hr_sequence")
    @SequenceGenerator(sequenceName = "aa_hr_sequence", allocationSize = 1, name = "hr_sequence")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @NotNull(message = "Boş olmamalıdır")
    @Temporal(TemporalType.DATE)
    @Column(name = "working_date", nullable = false)
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date workingDate;

    @Transient
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date workingDateFrom;

    @Pattern(regexp=".{1,6}",message="Minimum 1 maksimum 6 simvol ola bilər")
    @Column(name = "identifier")
    private String identifier;

    @Pattern(regexp=".{0,250}",message="Maksimum 250 simvol ola bilər")
    @Column(name = "description")
    private String description;

    @Column(name = "shortened_time", nullable = false)
    private Integer shortenedTime=1;

    @Column(name = "is_active", nullable = false, columnDefinition="boolean default true")
    private Boolean active = true;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", nullable = false)
    private Date createdDate = new Date();

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "created_by_admin_user_id")
    private User createdUser;


}
