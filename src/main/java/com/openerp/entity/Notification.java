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
@Table(name = "notification")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Notification {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO, generator = "notification_seq")
    @SequenceGenerator(sequenceName = "notification_seq", allocationSize = 1, name = "notification_seq")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "organization_id")
    private Organization organization;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dictionary_notification_id")
    private Dictionary type;

    @Column(name = "message_from")
    private String from;

    @Pattern(regexp=".{4,250}",message="Minimum 4 maksimum 250 simvol ola bilər")
    @Column(name = "message_to")
    private String to;

    @Pattern(regexp=".{1,250}",message="Minimum 1 maksimum 250 simvol ola bilər")
    @Column(name = "subject")
    private String subject;

    @Pattern(regexp=".{1,1000}",message="Minimum 1 maksimum 1000 simvol ola bilər")
    @Column(name = "message")
    private String message;

    @Pattern(regexp=".{0,1000}",message="Maksimum 1000 simvol ola bilər")
    @Column(name = "description")
    private String description;

    @Column(name = "attachment")
    private String attachment;

    @Column(name = "send_status", nullable = false)
    private Integer send = 0;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "dd.MM.yyyy HH:mm:ss")
    @Column(name = "sending_date", nullable = false)
    private Date sendingDate = new Date();

    @ToString.Exclude
    @Transient
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "dd.MM.yyyy HH:mm:ss")
    private Date sendingDateFrom;

    @Column(name = "is_active", nullable = false, columnDefinition="boolean default true")
    private Boolean active = true;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", nullable = false)
    private Date createdDate = new Date();

    public Notification(Dictionary type, Organization organization, String from, @Pattern(regexp = ".{4,250}", message = "Minimum 4 maksimum 250 simvol ola bilər") String to, @Pattern(regexp = ".{1,250}", message = "Minimum 1 maksimum 250 simvol ola bilər") String subject, @Pattern(regexp = ".{1,1000}", message = "Minimum 1 maksimum 1000 simvol ola bilər") String message, @Pattern(regexp = ".{1,1000}", message = "Minimum 1 maksimum 1000 simvol ola bilər") String description, String attachment) {
        this.type = type;
        this.organization = organization;
        this.from = from;
        this.to = to;
        this.subject = subject;
        this.message = message;
        this.description = description;
        this.attachment = attachment;
    }

    public Notification(Organization organization) {
        this.organization = organization;
    }

    public Notification(Organization organization, Date sendingDate) {
        this.organization = organization;
        this.sendingDate = sendingDate;
    }
}
