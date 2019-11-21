<%--
  Created by IntelliJ IDEA.
  User: irkan.ahmadov
  Date: 20.09.2019
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
                            <table class="table table-striped- table-bordered table-hover table-checkable" id="group_table">
                                <thead>
                                <tr>
                                    <th>HF nömrəsi</th>
                                    <th>Satış</th>
                                    <th>Status</th>
                                    <th>Məbləğ</th>
                                    <th>Tarix</th>
                                    <th>Yığımçı</th>
                                    <th>Kanal</th>
                                    <th>Referans</th>
                                    <th>Əməliyyat</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="t" items="${list}" varStatus="loop">
                                    <tr>
                                        <td><c:out value="${t.id}" /></td>
                                        <td>
                                            <span style="font-weight: bold; font-size: 16px;">SN: <c:out value="${t.sales.id}" />, <c:out value="${t.sales.customer.person.fullName}" /></span><br/>
                                            <c:out value="${t.sales.action.inventory.name}" />, <c:out value="${t.sales.action.inventory.barcode}" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${!t.approve}">
                                                    Təsdiq edilməyənlər
                                                </c:when>
                                                <c:otherwise>
                                                    Təsdiqlənənlər
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><c:out value="${t.price}" /> AZN</td>
                                        <th><fmt:formatDate value = "${t.invoiceDate}" pattern = "dd.MM.yyyy" /></th>
                                        <td><c:out value="${t.collector.person.fullName}" /></td>
                                        <td><c:out value="${t.paymentChannel.name}" /></td>
                                        <td><c:out value="${t.channelReferenceCode}" /></td>
                                        <td nowrap class="text-center">
                                            <c:set var="approve" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'approve')}"/>
                                            <c:choose>
                                                <c:when test="${approve.status}">
                                                    <a href="#" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${approve.object.name}"/>">
                                                        <i class="la <c:out value="${approve.object.icon}"/>"></i>
                                                    </a>
                                                </c:when>
                                            </c:choose>
                                            <c:set var="consolidate" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'consolidate')}"/>
                                            <c:choose>
                                                <c:when test="${consolidate.status}">
                                                    <a href="javascript:consolidate($('#form-consolidate'), '<c:out value="${utl:toJson(t)}" />', 'consolidate-modal');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${consolidate.object.name}"/>">
                                                        <i class="<c:out value="${consolidate.object.icon}"/>"></i>
                                                    </a>
                                                </c:when>
                                            </c:choose>
                                            <c:set var="edit" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'edit')}"/>
                                            <c:choose>
                                                <c:when test="${edit.status}">
                                                    <a href="javascript:edit($('#form'), '<c:out value="${utl:toJson(t)}" />', 'modal-operation', '<c:out value="${edit.object.name}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${edit.object.name}"/>">
                                                        <i class="<c:out value="${edit.object.icon}"/>"></i>
                                                    </a>
                                                </c:when>
                                            </c:choose>
                                            <c:set var="delete" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'delete')}"/>
                                            <c:choose>
                                                <c:when test="${delete.status}">
                                                    <a href="javascript:deleteData('<c:out value="${t.id}" />', '<c:out value="${t.description}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${delete.object.name}"/>">
                                                        <i class="<c:out value="${delete.object.icon}"/>"></i>
                                                    </a>
                                                </c:when>
                                            </c:choose>
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form" method="post" action="/sale/invoice" cssClass="form-group">
                    <form:hidden path="id"/>
                    <div class="form-group">
                        <form:label path="sales">Satış nömrəsi</form:label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="background-color: white; border-right: none;"><i class="la la-search"></i></span>
                            </div>
                            <form:input path="sales" class="form-control" placeholder="Satış nömrəsini daxil edin..." style="border-left: none;" />
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button" onclick="checkSales($('form').find('#sales'))">Yoxla</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <form:label path="price">Qiyməti</form:label>
                        <div class="input-group" >
                            <form:input path="price" cssClass="form-control" placeholder="Qiyməti daxil edin"/>
                            <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <i class="la la-usd"></i>
                                                    </span>
                            </div>
                        </div>
                        <form:errors path="price" cssClass="alert-danger control-label"/>
                    </div>
                    <div class="form-group">
                        <form:label path="invoiceDate">Hesab-faktura tarixi</form:label>
                        <div class="input-group date" >
                            <form:input path="invoiceDate" autocomplete="off" date="date" cssClass="form-control datepicker-element" placeholder="dd.MM.yyyy"/>
                            <div class="input-group-append">
                                    <span class="input-group-text">
                                        <i class="la la-calendar"></i>
                                    </span>
                            </div>
                        </div>
                        <form:errors path="invoiceDate" cssClass="control-label alert-danger" />
                    </div>
                    <div class="form-group">
                        <form:label path="description">Açıqlama</form:label>
                        <form:textarea path="description" cssClass="form-control"/>
                        <form:errors path="description" cssClass="alert-danger control-label"/>
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

<div class="modal fade" id="consolidate-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Yığımçıya təhkim edilmə</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form-consolidate" method="post" action="/sale/invoice/consolidate" cssClass="form-group">
                    <form:hidden path="id"/>
                    <div class="form-group">
                        <form:label path="collector">Yığımçı</form:label>
                        <form:select  path="collector" cssClass="custom-select form-control select2-single" multiple="single">
                            <c:forEach var="itemGroup" items="${employees}" varStatus="itemGroupIndex">
                                <optgroup label="${itemGroup.key}">
                                    <form:options items="${itemGroup.value}" itemLabel="person.fullName" itemValue="id"/>
                                </optgroup>
                            </c:forEach>
                        </form:select>
                        <form:errors path="collector" cssClass="control-label alert-danger"/>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submit($('#form-consolidate'));">Yadda saxla</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/assets/js/demo4/pages/crud/datatables/advanced/row-grouping.js" />" type="text/javascript"></script>

<script>
    function consolidate(form, data, modal){
        try {
            data = data.replace(/\&#034;/g, '"');
            var obj = jQuery.parseJSON(data);
            console.log(obj);
            $(form).find("#id").val(obj["id"]);
            if(obj["collector"]!=null){
                $("#collector option[value="+obj["collector"]["id"]+"]").attr("selected", "selected");
            }
            $('#' + modal).modal('toggle');
        } catch (e) {
            console.error(e);
        }
    }

    function checkSales(element){
        console.log($(element).val())
        if($(element).val().trim().length>0){
            swal.fire({
                text: 'Proses davam edir...',
                allowOutsideClick: false,
                onOpen: function() {
                    swal.showLoading();
                    $.ajax({
                        url: '/sale/sales/check/'+$(element).val(),
                        type: 'GET',
                        dataType: 'json',
                        beforeSend: function() {

                        },
                        success: function(data) {
                            console.log(data);
                            alert(data);
                            alert(data.length);
                            swal.close();
                            if(data.length>0){
                                swal.fire({
                                    title: "Məlumat tapıldı!",
                                    html: "Əlaqə saxlamağınızı xahiş edirik.",
                                    type: "info",
                                    cancelButtonText: 'Bağla',
                                    cancelButtonClass: 'btn btn-info',
                                    footer: '<a href>Məlumatlar yenilənsinmi?</a>'
                                });
                            } else {
                                swal.fire({
                                    title: "Məlumat tapılmadı!",
                                    html: "Satış kodunu doğru daxil edin!",
                                    type: "error",
                                    cancelButtonText: 'Bağla',
                                    cancelButtonColor: '#c40000',
                                    cancelButtonClass: 'btn btn-danger',
                                    footer: '<a href>Məlumatlar yenilənsinmi?</a>'
                                });
                            }
                        },
                        error: function() {
                            swal.fire({
                                title: "Xəta baş verdi!",
                                html: "Əlaqə saxlamağınızı xahiş edirik.",
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
    }
</script>



