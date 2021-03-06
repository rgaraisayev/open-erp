package com.openerp.repository;

import com.openerp.entity.Person;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PersonRepository extends JpaRepository<Person, Integer> {
    Person getPersonById(Integer id);
}