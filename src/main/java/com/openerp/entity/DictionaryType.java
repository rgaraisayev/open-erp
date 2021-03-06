package com.openerp.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "dictionary_type")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class DictionaryType {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO, generator = "dictionary_type_seq")
    @SequenceGenerator(sequenceName = "dictionary_type_seq", initialValue = 500, allocationSize = 1, name = "dictionary_type_seq")
    @Column(name = "id", unique = true, nullable = false)
    private Integer id;

    @Pattern(regexp=".{2,50}",message="Minimum 2 maksimum 50 simvol ola bilər")
    @Column(name = "name", unique = true, nullable = false)
    private String name;

    @Column(name = "attr1")
    private String attr1;

    @Column(name = "attr2")
    private String attr2;

    @Column(name = "is_active", nullable = false, columnDefinition="boolean default true")
    private Boolean active = true;

    @ToString.Exclude
    @JsonIgnore
    @OneToMany(mappedBy = "dictionaryType")
    private List<Dictionary> dictionaries;

    public DictionaryType(String name, String attr1, String attr2) {
        this.name = name;
        this.attr1 = attr1;
        this.attr2 = attr2;
    }
}
