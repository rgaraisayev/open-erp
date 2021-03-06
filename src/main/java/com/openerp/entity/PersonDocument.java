package com.openerp.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "person_document")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class PersonDocument {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO, generator = "person_document_seq")
    @SequenceGenerator(sequenceName = "person_document_seq", allocationSize = 1, name = "person_document_seq")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "person_id", nullable = false)
    private Person person;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dictionary_document_type_id")
    private Dictionary documentType;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "dd.MM.yyyy HH:mm:ss")
    @JsonFormat(pattern="dd.MM.yyyy HH:mm:ss")
    @Column(name = "upload_date", nullable = false)
    private Date uploadDate = new Date();

    @Lob
    @Column(name = "file_content")
    private byte[] fileContent;

    @Column(name = "extension")
    private String extension;

    @Column(name = "original_file_name")
    private String originalFileName;


    public PersonDocument(Person person, Dictionary documentType, byte[] fileContent,String extension, String originalFileName) {
        this.person = person;
        this.documentType = documentType;
        this.fileContent = fileContent;
        this.extension = extension;
        this.originalFileName = originalFileName;
    }
}
