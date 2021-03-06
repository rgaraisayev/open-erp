package com.openerp.domain;

import com.openerp.entity.SalesInventory;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.DecimalMin;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class LogFile {
    private Integer count=1000;
}
