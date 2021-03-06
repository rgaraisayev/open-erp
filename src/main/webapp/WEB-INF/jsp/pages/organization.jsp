<%--
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
<link href="<c:url value="/assets/vendors/custom/jstree/jstree.bundle.css" />" rel="stylesheet" type="text/css" />
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <div class="row">

        <div class="col-lg-6">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">
                    <div id="kt_tree_2" class="tree-demo">
                        <c:set var="edit" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'edit')}"/>
                        <c:set var="delete" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'delete')}"/>
                        <c:choose>
                                <c:when test="${not empty list}">
                                    <ul>
                                        <c:forEach var="t" items="${list}" varStatus="loop">
                                            <c:if test="${t.active}">
                                                <li data-jstree='{ "opened" : true }'>
                                                    <a href="javascript:showOrganization('<c:out value="${utl:toJson(t)}" />', '<c:out value="${edit.status}" />', '<c:out value="${edit.object.icon}" />', '<c:out value="${delete.status}" />', '<c:out value="${delete.object.icon}" />');"><c:out value="${t.name}" /></a>
                                                    <c:choose>
                                                        <c:when test="${not empty t.children}">
                                                            <ul>
                                                                <c:forEach var="p" items="${t.children}" varStatus="loop">
                                                                    <c:if test="${p.active}">
                                                                        <li data-jstree='{ "opened" : true }'>
                                                                            <a href="javascript:showOrganization('<c:out value="${utl:toJson(p)}" />', '<c:out value="${edit.status}" />', '<c:out value="${edit.object.icon}" />', '<c:out value="${delete.status}" />', '<c:out value="${delete.object.icon}" />');"><c:out value="${p.name}" /></a>
                                                                            <c:choose>
                                                                                <c:when test="${not empty p.children}">
                                                                                    <ul>
                                                                                        <c:forEach var="f" items="${p.children}" varStatus="loop">
                                                                                            <c:if test="${f.active}">
                                                                                                <li data-jstree='{ "opened" : true }'>
                                                                                                    <a href="javascript:showOrganization('<c:out value="${utl:toJson(f)}" />', '<c:out value="${edit.status}" />', '<c:out value="${edit.object.icon}" />', '<c:out value="${delete.status}" />', '<c:out value="${delete.object.icon}" />');"><c:out value="${f.name}" /></a>
                                                                                                    <c:choose>
                                                                                                        <c:when test="${not empty f.children}">
                                                                                                            <ul>
                                                                                                                <c:forEach var="m" items="${f.children}" varStatus="loop">
                                                                                                                    <c:if test="${m.active}">
                                                                                                                        <li data-jstree='{ "opened" : true }'>
                                                                                                                            <a href="javascript:showOrganization('<c:out value="${utl:toJson(m)}" />', '<c:out value="${edit.status}" />', '<c:out value="${edit.object.icon}" />', '<c:out value="${delete.status}" />', '<c:out value="${delete.object.icon}" />');"><c:out value="${m.name}" /></a>
                                                                                                                        </li>
                                                                                                                    </c:if>
                                                                                                                </c:forEach>
                                                                                                            </ul>
                                                                                                        </c:when>
                                                                                                    </c:choose>
                                                                                                </li>
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                    </ul>
                                                                                </c:when>
                                                                            </c:choose>
                                                                        </li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:when>
                                                    </c:choose>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>

                                </c:when>
                                <c:otherwise>
                                    Məlumat tapılmadı
                                </c:otherwise>
                            </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">
                    <div id="organization-view-content">
                        Heç bir struktur seçilməyib...
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="modal-operation" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Yeni struktur yarat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form" method="post" action="/hr/organization" cssClass="form-group">
                    <form:hidden path="id"/>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="organization.id">Yuxarı struktur</form:label>
                                <form:select  path="organization.id" cssClass="custom-select form-control">
                                    <form:option value=""></form:option>
                                    <form:options items="${organizations}" itemLabel="name" itemValue="id" />
                                </form:select>
                                <form:errors path="organization.id" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="type.id">Strukturun tipi</form:label>
                                <form:select  path="type.id" cssClass="custom-select form-control">
                                    <form:option value=""></form:option>
                                    <form:options items="${organization_types}" itemLabel="name" itemValue="id" />
                                </form:select>
                                <form:errors path="type.id" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <form:label path="name">Ad</form:label>
                        <form:input path="name" cssClass="form-control" placeholder="Adı daxil edin"/>
                        <form:errors path="name" cssClass="control-label alert-danger" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:label path="description">Açıqlama</form:label>
                                <form:input path="description" cssClass="form-control" placeholder="Açıqlama daxil edin" />
                                <form:errors path="description" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                    </div>
                    <hr width="100%" />
                    <div class="form-group">
                        <form:label path="contact.email">Email</form:label>
                        <div class="input-group" >
                            <div class="input-group-prepend"><span class="input-group-text"><i class="la la-at"></i></span></div>
                            <form:input path="contact.email" cssClass="form-control" placeholder="example@example.com"/>
                        </div>
                        <form:errors path="contact.email" cssClass="control-label alert-danger" />
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="contact.mobilePhone">Nömrə</form:label>
                                <div class="input-group" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-phone"></i></span></div>
                                    <form:input path="contact.mobilePhone" cssClass="form-control" placeholder="505505550"/>
                                </div>
                                <form:errors path="contact.mobilePhone" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="contact.homePhone">Şəhər nömrəsi</form:label>
                                <div class="input-group" >
                                    <div class="input-group-prepend"><span class="input-group-text"><i class="la la-phone"></i></span></div>
                                    <form:input path="contact.homePhone" cssClass="form-control" placeholder="124555050"/>
                                </div>
                                <form:errors path="contact.homePhone" cssClass="control-label alert-danger" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <form:label path="contact.city.id">Şəhər</form:label>
                                <form:select  path="contact.city.id" cssClass="custom-select form-control">
                                    <form:options items="${cities}" itemLabel="name" itemValue="id" />
                                </form:select>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="form-group">
                                <form:label path="contact.address">Ünvan</form:label>
                                <div class="input-group" >
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="la la-street-view"></i>
                                        </span>
                                    </div>
                                    <form:input path="contact.address" cssClass="form-control" placeholder="Küçə adı, ev nömrəsi və s."/>
                                </div>
                                <form:errors path="contact.address" cssClass="control-label alert-danger" />
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

<script src="<c:url value="/assets/vendors/custom/jstree/jstree.bundle.js" />" type="text/javascript"></script>
<script src="<c:url value="/assets/js/demo4/pages/components/extended/treeview.js" />" type="text/javascript"></script>
<script>
    function showOrganization(data, edit_status, edit_icon, delete_status, delete_icon){
        let obj = jQuery.parseJSON(data.replace(/\&#034;/g, '"'));
        let content = '<div class="row">' +
            '<div class="col-sm-8">' +
            '<label class="view-label-1">'+obj.name+'</label><br/>';
        if(obj.type.name!=null){
            content += '<label class="view-label-2">'+obj.type.name+'</label><br/>';
        }
        if(obj.description!=null){
            content += '<label class="view-label-2">'+obj.description+'</label><br/>';
        }
        if(obj.contact.mobilePhone!=null){
            content += '<label class="view-label-2">'+obj.contact.mobilePhone+'</label><br/>';
        }
        if(obj.contact.homePhone!=null){
            content += '<label class="view-label-2">'+obj.contact.homePhone+'</label><br/>';
        }
        if(obj.contact.email!=null){
            content += '<label class="view-label-2">'+obj.contact.email+'</label><br/>';
        }
        if(obj.contact.address!=null){
            content += '<label class="view-label-2">'+obj.contact.address+'</label><br/>';
        }
        if(obj.contact.city.name!=null){
            content += '<label class="view-label-2">'+obj.contact.city.name+'</label>';
        }
        content += '</div>';

        if(edit_status){
            content+='<div class="col-sm-2 text-center">'+
                '<a href="javascript:organization(\'edit\', $(\'#form\'), \''+obj.id+'\', \'modal-operation\', \'Redaktə\')"  class="btn btn-sm btn-clean btn-icon btn-icon-md" >' +
                '<i class="'+edit_icon+'" style="font-size: 24px;"></i>' +
                '</a> ' +
                '</div>';
        }

        if(delete_status){
            content+='<div class="col-sm-2 text-center">' +
                '<a href="javascript:deleteData('+obj.id+', \''+obj.name+'\')"  class="btn btn-sm btn-clean btn-icon btn-icon-md" >' +
                '<i class="'+delete_icon+'" style="font-size: 24px;"></i>' +
                '</a> ' +
                '</div>'
        }

        content+='</div>';

        $("#organization-view-content").html(content);
    }

    $( "#form" ).validate({
        rules: {
            "organization.id": {
                required: true
            },
            "type.id": {
                required: true
            },
            name: {
                required: true
            },
            "contact.mobilePhone": {
                required: true
            },
            "contact.address": {
                required: true
            }
        },
        invalidHandler: function(event, validator) {
                    KTUtil.scrollTop();
            swal.close();
        },
    });

    $("input[name='contact.email']").inputmask({
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

    $("input[name='contact.mobilePhone']").inputmask("mask", {
        "mask": "(999) 999-9999"
    });

    $("input[name='contact.homePhone']").inputmask("mask", {
        "mask": "(999) 999-9999"
    });

    function organization(oper, form, dataId, modal, modal_title){
        swal.fire({
            text: 'Proses davam edir...',
            allowOutsideClick: false,
            onOpen: function() {
                swal.showLoading();
                $.ajax({
                    url: '/hr/api/organization/'+dataId,
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

