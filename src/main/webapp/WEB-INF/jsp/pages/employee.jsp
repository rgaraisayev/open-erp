<%@ page import="java.util.Date" %>
<%@ page import="com.openerp.util.DateUtility" %><%--
  Created by IntelliJ IDEA.
  User: irkan.ahmadov
  Date: 01.09.2019
  Time: 1:22
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="utl" uri="/WEB-INF/tld/Util.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">

<c:choose>
    <c:when test="${not empty list}">
        <c:set var="view" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'view')}"/>
        <c:set var="export" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'export')}"/>
        <c:set var="payroll" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'payroll')}"/>
        <c:set var="sale" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'sale')}"/>
        <c:set var="edit" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'edit')}"/>
        <c:set var="delete" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'delete')}"/>
<table class="table table-striped- table-bordered table-hover table-checkable" id="group_table">
    <thead>
    <tr>
        <th>№</th>
        <th>ID</th>
        <th>Struktur</th>
        <th>Ad Soyad Ata adı</th>
        <th>Vəzifə</th>
        <th>İşə başlıyıb</th>
        <th>İşdən ayrılıb</th>
        <th>Aktiv</th>
        <th>Əməliyyat</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="t" items="${list}" varStatus="loop">
        <tr data="<c:out value="${t.id}" />">
            <td>${loop.index + 1}</td>
            <td><c:out value="${t.id}" /></td>
            <td><c:out value="${t.organization.name}" /></td>
            <th><c:out value="${t.person.firstName}"/> <c:out value="${t.person.lastName}"/> <c:out value="${t.person.fatherName}"/></th>
            <td><c:out value="${t.position.name}" /></td>
            <td><fmt:formatDate value = "${t.contractStartDate}" pattern = "dd.MM.yyyy" /></td>
            <td><fmt:formatDate value = "${t.contractEndDate}" pattern = "dd.MM.yyyy" /></td>
            <c:choose>
                <c:when test="${empty t.contractEndDate}">
                    <td>
                        <span class="kt-badge kt-badge--success kt-badge--inline kt-badge--pill">Aktivdir</span>
                    </td>
                </c:when>
                <c:otherwise>
                    <td>
                        <span class="kt-badge kt-badge--danger kt-badge--inline kt-badge--pill">Aktiv deyil</span>
                    </td>
                </c:otherwise>
            </c:choose>
            <td nowrap class="text-center">
                <span class="dropdown">
                    <a href="#" class="btn btn-sm btn-clean btn-icon btn-icon-md" data-toggle="dropdown" aria-expanded="true">
                      <i class="la la-ellipsis-h"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <c:if test="${payroll.status}">
                            <a href="javascript:employee('edit', $('#form-payroll'), '<c:out value="${t.id}" />', 'modal-payroll', '<c:out value="${payroll.object.name}" />');" class="dropdown-item" title="<c:out value="${payroll.object.name}"/>">
                                <i class="<c:out value="${payroll.object.icon}"/>"></i> <c:out value="${payroll.object.name}"/>
                            </a>
                        </c:if>
                        <c:if test="${sale.status}">
                            <a href="javascript:employee('edit', $('#form-sale'), '<c:out value="${t.id}" />', 'modal-sale', '<c:out value="${sale.object.name}" />');" class="dropdown-item" title="<c:out value="${sale.object.name}"/>">
                                <i class="<c:out value="${sale.object.icon}"/>"></i> <c:out value="${sale.object.name}"/>
                            </a>
                        </c:if>
                        <c:if test="${delete.status}">
                            <a href="javascript:deleteData('<c:out value="${t.id}" />', '<c:out value="${t.person.firstName}"/> <c:out value="${t.person.lastName}"/> <c:out value="${t.person.fatherName}"/>');" class="dropdown-item" title="<c:out value="${delete.object.name}"/>">
                                <i class="<c:out value="${delete.object.icon}"/>"></i> <c:out value="${delete.object.name}"/>
                            </a>
                        </c:if>
                    </div>
                </span>
                <c:if test="${view.status}">
                    <a href="javascript:employee('view', $('#form'), '<c:out value="${t.id}" />', 'modal-operation', '<c:out value="${view.object.name}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${view.object.name}"/>">
                        <i class="<c:out value="${view.object.icon}"/>"></i>
                    </a>
                </c:if>
                <c:if test="${edit.status}">
                    <a href="javascript:employee('edit', $('#form'), '<c:out value="${t.id}" />', 'modal-operation', '<c:out value="${edit.object.name}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${edit.object.name}"/>">
                        <i class="<c:out value="${edit.object.icon}"/>"></i>
                    </a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
    </c:when>
    <c:otherwise>
        <div class="row">
                                <div class="col-md-12 text-center" style="letter-spacing: 10px;">
                                    Məlumat yoxdur
                                </div>
                            </div>
    </c:otherwise>
</c:choose>
                </div>
            </div>
        </div>

    </div>
</div>


<div class="modal fade" id="modal-operation" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form" method="post" action="/hr/employee" cssClass="form-group">
                    <form:hidden path="id"/>
                    <form:hidden path="organization.id"/>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.firstName">Ad</form:label>
                                <form:input path="person.firstName" cssClass="form-control" placeholder="Adı daxil edin Məs: Səbuhi"/>
                                <form:errors path="person.firstName" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.lastName">Soyad</form:label>
                                <form:input path="person.lastName" cssClass="form-control" placeholder="Soyadı daxil edin Məs: Vəliyev"/>
                                <form:errors path="person.lastName" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.fatherName">Ata adı</form:label>
                                <form:input path="person.fatherName" cssClass="form-control" placeholder="Ata adını daxil edin"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <form:label path="person.birthday">Doğum tarixi</form:label>
                                <div class="input-group date" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-calendar"></i></span></div>
                                    <form:input path="person.birthday" autocomplete="off" cssClass="form-control datepicker-element" date_="date_" placeholder="dd.MM.yyyy"/>
                                </div>
                                <form:errors path="person.birthday" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <form:label path="person.gender.id" cssClass="mb-3">Cins</form:label><br/>
                                <c:forEach var="t" items="${genders}" varStatus="loop">
                                    <label class="kt-radio kt-radio--brand">
                                        <form:radiobutton path="person.gender.id" value="${t.id}"/> <c:out value="${t.name}"/>
                                        <span></span>
                                    </label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <form:label path="person.maritalStatus.id">Ailə vəziyyəti</form:label>
                                <form:select  path="person.maritalStatus.id" cssClass="custom-select form-control">
                                    <form:option value=""></form:option>
                                    <form:options items="${marital_statuses}" itemLabel="name" itemValue="id" />
                                </form:select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <form:label path="person.nationality.id">Milliyət</form:label>
                                <form:select  path="person.nationality.id" cssClass="custom-select form-control">
                                    <form:option value=""></form:option>
                                    <form:options items="${nationalities}" itemLabel="name" itemValue="id" />
                                </form:select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.idCardSerialNumber">Ş.v - nin seriya nömrəsi</form:label>
                                <form:input path="person.idCardSerialNumber" cssClass="form-control" placeholder="AA0822304"/>
                                <form:errors path="person.idCardSerialNumber" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.idCardPinCode">Ş.v - nin pin kodu</form:label>
                                <form:input path="person.idCardPinCode" cssClass="form-control" cssStyle="text-transform: uppercase;" maxlength="7" placeholder="Məs: 4HWL0AM"/>
                                <form:errors path="person.idCardPinCode" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.voen">VÖEN</form:label>
                                <form:input path="person.voen" cssClass="form-control" placeholder="Məs: 0000000000"/>
                                <form:errors path="person.voen" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                    </div>
                    <hr style="width: 100%"/>
                    <div class="row">
                        <div class="col-md-7">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:label path="contractStartDate">İşə başlama tarixi</form:label>
                                        <div class="input-group date" >
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="la la-calendar"></i></span></div>
                                            <form:input path="contractStartDate" autocomplete="off" date_="date_" cssClass="form-control datepicker-element" placeholder="dd.MM.yyyy"/>
                                        </div>
                                        <form:errors path="contractStartDate" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:label path="position.id">Vəzifə</form:label>
                                        <form:select  path="position.id" cssClass="custom-select form-control">
                                            <form:option value=""></form:option>
                                            <form:options items="${positions}" itemLabel="name" itemValue="id" />
                                        </form:select>
                                        <form:errors path="position.id" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:label path="contractEndDate">İşdən ayrılma tarixi</form:label>
                                        <div class="input-group date" >
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="la la-calendar"></i></span></div>
                                            <form:input path="contractEndDate" autocomplete="off" date_="date_" cssClass="form-control datepicker-element" placeholder="dd.MM.yyyy"/>
                                        </div>
                                        <form:errors path="contractEndDate" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:label path="leaveReason">İşdən ayrılma səbəbi</form:label>
                                        <form:input path="leaveReason" cssClass="form-control" placeholder=""/>
                                        <form:errors path="leaveReason" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <form:label path="socialCardNumber">Sosial kart nömrəsi</form:label>
                                        <form:input path="socialCardNumber" cssClass="form-control" placeholder="Daxil edin"/>
                                        <form:errors path="socialCardNumber" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <form:label path="bankAccountNumber">Bank hesab nömrəsi</form:label>
                                        <form:input path="bankAccountNumber" cssClass="form-control" placeholder="Daxil edin"/>
                                        <form:errors path="bankAccountNumber" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <form:label path="bankCardNumber">Bank kart nömrəsi</form:label>
                                        <form:input path="bankCardNumber" cssClass="form-control" placeholder="Daxil edin"/>
                                        <form:errors path="bankCardNumber" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 bg-light">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <form:label path="employeeRestDays">İstirahət günləri</form:label>
                                        <form:select  path="employeeRestDays" cssClass="custom-select form-control" multiple="multiple">
                                            <form:options items="${week_days}" itemLabel="name" itemValue="id" />
                                        </form:select>
                                        <form:errors path="employeeRestDays" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="kt-checkbox kt-checkbox--brand">
                                            <form:checkbox path="person.disability"/> Əlillik var
                                            <span></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <label class="kt-checkbox kt-checkbox--danger">
                                            <form:checkbox path="specialistOrManager"/> Mütəxəsis və ya rəhbər
                                            <span></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="kt-checkbox kt-checkbox--warning">
                                            <form:checkbox path="salary"/> Maaş hesablansın
                                            <span></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row" style="margin-top: -4px;">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <form:label path="description">Açıqlama</form:label>
                                        <form:textarea path="description" cssClass="form-control"/>
                                        <form:errors path="description" cssClass="control-label alert-danger" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr style="width: 100%"/>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.contact.email">Email</form:label>
                                <div class="input-group" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-at"></i></span></div>
                                    <form:input path="person.contact.email" cssClass="form-control" placeholder="example@example.com"/>
                                </div>
                                <form:errors path="person.contact.email" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.contact.mobilePhone">Nömrə</form:label>
                                <div class="input-group" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-phone"></i></span></div>
                                    <form:input path="person.contact.mobilePhone" cssClass="form-control" placeholder="505505550"/>
                                </div>
                                <form:errors path="person.contact.mobilePhone" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.contact.homePhone">Şəhər nömrəsi</form:label>
                                <div class="input-group" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-phone"></i></span></div>
                                    <form:input path="person.contact.homePhone" cssClass="form-control" placeholder="124555050"/>
                                </div>
                                <form:errors path="person.contact.homePhone" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="person.contact.city.id">Şəhər</form:label>
                                <form:select  path="person.contact.city.id" cssClass="custom-select form-control">
                                    <form:option value=""></form:option>
                                    <form:options items="${cities}" itemLabel="name" itemValue="id" />
                                </form:select>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="form-group">
                                <form:label path="person.contact.address">Ünvan</form:label>
                                <div class="input-group" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-street-view"></i></span></div>
                                    <form:input path="person.contact.address" cssClass="form-control" placeholder="Küçə adı, ev nömrəsi və s."/>
                                </div>
                                <form:errors path="person.contact.address" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submit($('#form'));">Yadda saxla</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-payroll" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Əmək haqqı məlumatları</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form-payroll" method="post" action="/hr/employee/payroll" cssClass="form-group">
                    <input type="hidden" name="id"/>
                    <div class="row mb-4">
                        <div class="col-md-6 text-right">
                            <input type="text" name="person.firstName" class="style-none" disabled style="text-align: right;">
                        </div>
                        <div class="col-md-6">
                            <input type="text" name="person.lastName" class="style-none" disabled>
                        </div>
                    </div>
                    <c:forEach var="t" items="${employee_payroll_fields}" varStatus="loop">
                        <div class="form-group-0_5">
                            <div class="row">
                                <div class="col-md-8 text-right" style="padding-top: 2px;">
                                    <input type="text" class="form-control" name="employeePayrollDetails[${loop.index}].employeePayrollField.name" style="border: none; background: none;  width: 100%" readonly/>
                                </div>
                                <div class="col-md-4">
                                    <input type="hidden" name="employeePayrollDetails[${loop.index}].employeePayrollField.id" value="${t.id}"/>
                                    <input type="hidden" name="employeePayrollDetails[${loop.index}].key" value="${t.attr1}"/>
                                    <c:choose>
                                        <c:when test="${t.attr1 eq '{previous_work_experience}'}">
                                            <input type="text" name="employeePayrollDetails[${loop.index}].value" onkeyup="calculateVacationDay($('input[name=\'person.disability\']'), $('input[name=specialistOrManager]'), $('input[name=contractStartDate]'), $('input[key=\'{previous_work_experience}\']'))" class="form-control" />
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" name="employeePayrollDetails[${loop.index}].value" class="form-control" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submit($('#form-payroll'));">Yadda saxla</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-sale" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Satış məlumatları</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form-sale" method="post" action="/hr/employee/sale" cssClass="form-group">
                    <input type="hidden" name="id"/>
                    <div class="row mb-4">
                        <div class="col-md-6 text-right">
                            <input type="text" name="person.firstName" class="style-none" disabled style="text-align: right;">
                        </div>
                        <div class="col-md-6">
                            <input type="text" name="person.lastName" class="style-none" disabled>
                        </div>
                    </div>
                    <c:forEach var="t" items="${employee_sale_fields}" varStatus="loop">
                        <div class="form-group-0_5">
                            <div class="row">
                                <div class="col-md-4 text-right" style="padding-top: 2px;">
                                    <input type="text" class="form-control" name="employeeSaleDetails[${loop.index}].employeeSaleField.name" style="border: none; background: none;  width: 100%" readonly/>
                                </div>
                                <div class="col-md-8">
                                    <input type="hidden" name="employeeSaleDetails[${loop.index}].employeeSaleField.id" value="${t.id}"/>
                                    <input type="hidden" name="employeeSaleDetails[${loop.index}].key" value="${t.attr1}"/>
                                    <input type="text" name="employeeSaleDetails[${loop.index}].value" value="${t.attr2}" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <%--<c:forEach var="t" items="${employee_sale_fields}" varStatus="loop">
                        <div class="form-group-0_5">
                            <div class="row">
                                <div class="col-md-3 text-right" style="padding-top: 8px;">
                                    <label><c:out value="${t.name}"/></label>
                                </div>
                                <div class="col-md-9">
                                    <input type="hidden" name="employeeSaleDetails[${loop.index}].employeeSalaryField" value="${t.id}"/>
                                    <input type="hidden" name="employeeSaleDetails[${loop.index}].key" value="${t.attr1}"/>
                                    <input type="text" name="employeeSaleDetails[${loop.index}].value" value="${t.attr2}" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </c:forEach>--%>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submit($('#form-sale'));">Yadda saxla</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('#employeeRestDays').select2({
        placeholder: "Həftə günlərini seçin",
        allowClear: true
    });


    $('#group_table').DataTable({
        <c:if test="${export.status}">
        dom: 'B<"clear">lfrtip',
        buttons: [
               $.extend( true, {}, buttonCommon, {
                    extend: 'copyHtml5'
                } ),
                $.extend( true, {}, buttonCommon, {
                    extend: 'csvHtml5'
                } ),
                $.extend( true, {}, buttonCommon, {
                    extend: 'excelHtml5'
                } ),
                $.extend( true, {}, buttonCommon, {
                    extend: 'pdfHtml5'
                } ),
                $.extend( true, {}, buttonCommon, {
                    extend: 'print'
                } )
        ],
        </c:if>
        responsive: true,
fixedHeader: {
   headerOffset: $('#kt_header').outerHeight()
},
        pageLength: 100,
        order: [[2, 'asc']],
        drawCallback: function(settings) {
            var api = this.api();
            var rows = api.rows({page: 'current'}).nodes();
            var last = null;

            api.column(2, {page: 'current'}).data().each(function(group, i) {
                if (last !== group) {
                    $(rows).eq(i).before(
                        '<tr class="group"><td colspan="30">' + group + '</td></tr>'
                    );
                    last = group;
                }
            });
        },
        columnDefs: [
            {
                targets: [2],
                visible: false
            }
        ]
    });
    
    function calculateVacationDay(disability, specialistOrManager, contractStartDate, previousWorkExperience) {
        $("input[key='{main_vacation_days}']").val("21");
        if($(disability).is(":checked")){
            $("input[key='{main_vacation_days}']").val("43");
        }

        if($(specialistOrManager).is(":checked") && !$(disability).is(":checked")){
            $("input[key='{main_vacation_days}']").val("30");
        }
        $("input[key='{additional_vacation_days}']").val("0");
        var current = calculateCurrentWorkExperience($(contractStartDate).val(), "<%= DateUtility.getFormattedDate(new Date())%>");
        var experience = parseFloat(current)+parseFloat($(previousWorkExperience).val());
        if(experience>=15){
            $("input[key='{additional_vacation_days}']").val("6");
        } else if(experience>=10){
            $("input[key='{additional_vacation_days}']").val("4");
        } else if(experience>=5){
            $("input[key='{additional_vacation_days}']").val("2");
        }
        if($(disability).is(":checked")){
            $("input[key='{additional_vacation_days}']").val("0");
        }
    }

    function calculateCurrentWorkExperience(contractStartDate, today){
        var array1 = contractStartDate.split(".");
        var array2 = today.split(".");
        return parseFloat(array2[2])-parseFloat(array1[2])
    }
    $('#group_table tbody').on('dblclick', 'tr', function () {
        <c:if test="${view.status}">
            employee('view', $('#form'), $(this).attr('data'), 'modal-operation', '<c:out value="${view.object.name}" />');
        </c:if>
    });

    $( "#form" ).validate({
        rules: {
            "position.id": {
                required: true
            },
            contractStartDate: {
                required: true
            },
            socialCardNumber: {
                required: true
            },
            "person.firstName": {
                required: true,
                minlength: 1
            },
            "person.lastName": {
                required: true,
                minlength: 1
            },
            "person.idCardPinCode": {
                required: true,
                maxlength: 7,
                minlength: 7
            },
            "person.birthday": {
                required: true
            },
            "person.gender.id": {
                required: true
            },
            "person.maritalStatus.id": {
                required: true
            },
            "person.nationality.id": {
                required: true
            },
            "person.contact.email": {
                required: true
            },
            "person.contact.mobilePhone": {
                required: true
            },
            "person.contact.city.id": {
                required: true
            },
            "person.contact.address": {
                required: true
            }
        },
        invalidHandler: function(event, validator) {
                    KTUtil.scrollTop();
            swal.close();
        },
    });

    $("input[name='person.contact.email']").inputmask({
        mask: "*{1,20}[.*{1,20}][.*{1,20}][.*{1,20}]@*{1,20}[.*{2,6}][.*{1,2}]",
        greedy: false,
        onBeforePaste: function (pastedValue, opts) {
            pastedValue = pastedValue.toLowerCase();
            return pastedValue.replace("mailto:", "");
        },
        definitions: {
            '*': {
                validator: "[0-9A-Za-z!#$%&'*+/=?^_`{|}~\-]",
                cardinality: 1,
                casing: "lower"
            }
        }
    });

    $("input[name='person.contact.mobilePhone']").inputmask("mask", {
        "mask": "(999) 999-9999"
    });

    $("input[name='person.contact.homePhone']").inputmask("mask", {
        "mask": "(999) 999-9999"
    });

    $("input[name='bankCardNumber']").inputmask("mask", {
        "mask": "9999-9999-9999-9999"
    });

    <c:forEach var="t" items="${employee_payroll_fields}" varStatus="loop">
        $("input[name='employeePayrollDetails[<c:out value="${loop.index}"/>].value']").inputmask('decimal', {
            rightAlignNumerics: false
        });
    </c:forEach>

    $( "#form-payroll" ).validate({
        rules: {
            <c:forEach var="t" items="${employee_payroll_fields}" varStatus="loop">
            "employeePayrollDetails[<c:out value="${loop.index}"/>].value" : {
                required: true,
                number: true
            },
            </c:forEach>
        },
        invalidHandler: function(event, validator) {
                    KTUtil.scrollTop();
            swal.close();
        },
    });

    $( "#form-sale" ).validate({
        rules: {
            <c:forEach var="t" items="${employee_sale_fields}" varStatus="loop">
            "employeeSaleDetails[<c:out value="${loop.index}"/>].value" : {
                required: false
            },
            </c:forEach>
        },
        invalidHandler: function(event, validator) {
                    KTUtil.scrollTop();
            swal.close();
        },
    });

    function employee(oper, form, dataId, modal, modal_title){
        swal.fire({
            text: 'Proses davam edir...',
            allowOutsideClick: false,
            onOpen: function() {
                swal.showLoading();
                $.ajax({
                    url: '/hr/api/employee/'+dataId,
                    type: 'GET',
                    dataType: 'text',
                    beforeSend: function() {

                    },
                    success: function(data) {
                        if(oper==="view"){
                            view(form, data, modal, modal_title)
                        } else if(oper==="edit"){
                            edit(form, data, modal, modal_title)
                        }
                        swal.close();
                    },
                    error: function() {
                        swal.fire({
                            title: "Xəta",
                            html: "Xəta baş verdi!",
                            type: "error",
                            cancelButtonText: 'Bağla',
                            cancelButtonColor: '#c40000',
                            cancelButtonClass: 'btn btn-danger',
                            footer: '<a href>Məlumatlar yenilənsinmi?</a>'
                        });
                    }
                })
            }
        });
    }
</script>