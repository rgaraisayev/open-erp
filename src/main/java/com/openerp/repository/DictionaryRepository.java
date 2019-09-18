package com.openerp.repository;

import com.openerp.entity.Dictionary;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DictionaryRepository extends JpaRepository<Dictionary, Integer> {
    List<Dictionary> getDictionariesByActiveTrueAndDictionaryType_Attr1(String attr1);
    Dictionary getDictionaryById(int id);
}