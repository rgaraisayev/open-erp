package com.openerp.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class WSResponse {
    private String code;
    private String message;
    private Object object;

    public WSResponse(String code, String message, Object object) {
        this.code = code;
        this.message = message;
        this.object = object;
    }

    public WSResponse(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
