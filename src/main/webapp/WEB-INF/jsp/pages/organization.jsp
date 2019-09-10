<%--
  Created by IntelliJ IDEA.
  User: irkan.ahmadov
  Date: 01.09.2019
  Time: 1:22
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="uj" uri="/WEB-INF/tld/UtilJson.tld"%>
<link href="<c:url value="/assets/vendors/custom/jstree/jstree.bundle.css" />" rel="stylesheet" type="text/css" />
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <div class="row">

        <div class="col-lg-6">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">
                    <div id="kt_tree_2" class="tree-demo">
                            <c:choose>
                                <c:when test="${not empty list}">
                                    <ul>
                                        <c:forEach var="t" items="${list}" varStatus="loop">
                                            <li data-jstree='{ "opened" : true }'>
                                                <a href="javascript:show('dataaaa');"><c:out value="${t.name}" /> <%--${uj:toJson(t)}--%></a>
                                                <c:choose>
                                                    <c:when test="${not empty t.children}">
                                                    <ul>
                                                        <c:forEach var="p" items="${t.children}" varStatus="loop">
                                                            <li data-jstree='{ "opened" : true }'>
                                                                <c:out value="${p.name}" />
                                                                <c:choose>
                                                                    <c:when test="${not empty p.children}">
                                                                        <ul>
                                                                            <c:forEach var="f" items="${p.children}" varStatus="loop">
                                                                                <li data-jstree='{ "opened" : true }'>
                                                                                    <c:out value="${f.name}" />
                                                                                    <c:choose>
                                                                                        <c:when test="${not empty f.children}">
                                                                                            <ul>
                                                                                                <c:forEach var="m" items="${f.children}" varStatus="loop">
                                                                                                    <li data-jstree='{ "opened" : true }'>
                                                                                                        <c:out value="${m.name}" />
                                                                                                    </li>
                                                                                                </c:forEach>
                                                                                            </ul>
                                                                                        </c:when>
                                                                                    </c:choose>
                                                                                </li>
                                                                            </c:forEach>
                                                                        </ul>
                                                                    </c:when>
                                                                </c:choose>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                    </c:when>
                                                </c:choose>
                                            </li>
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
                    Struktur mlumatlarının yer alacağı kontent: Struktura baxış
                </div>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="modal-create-new" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Yeni struktur yarat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" method="post" action="/hr/organization" cssClass="form-group">
                    <form:hidden path="id"/>
                    <div class="form-group">
                        <form:label path="organization">Yuxarı struktur</form:label>
                        <form:select  path="organization" cssClass="custom-select form-control">
                            <form:options items="${organizations}" itemLabel="name" itemValue="id" />
                        </form:select>
                    </div>
                    <div class="form-group">
                        <form:label path="name">Ad</form:label>
                        <form:input path="name" cssClass="form-control" placeholder="Adı daxil edin"/>
                    </div>
                    <div class="form-group">
                        <form:label path="description">Açıqlama</form:label>
                        <form:input path="description" cssClass="form-control" placeholder="Açıqlama daxil edin" />
                    </div>
                    <hr width="100%" />
                    <div class="form-group">
                        <form:label path="organizationContact.email">Email</form:label>
                        <form:input path="organizationContact.email" cssClass="form-control" placeholder="example@example.com"/>
                        <form:errors path="organizationContact.email" cssClass="control-label alert alert-danger" />
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="organizationContact.mobilePhone">Mobil nömrə</form:label>
                                <form:input path="organizationContact.mobilePhone" cssClass="form-control" placeholder="505505050"/>
                                <form:errors path="organizationContact.mobilePhone" cssClass="control-label alert alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="organizationContact.homePhone">Şəhər nömrəsi</form:label>
                                <form:input path="organizationContact.homePhone" cssClass="form-control" placeholder="125505050"/>
                                <form:errors path="organizationContact.homePhone" cssClass="control-label alert alert-danger" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="organizationContact.city">Şəhər/Rayon</form:label>
                                <form:select  path="organizationContact.city" cssClass="custom-select form-control">
                                    <form:options items="${cities}" itemLabel="name" itemValue="id" />
                                </form:select>
                                <form:errors path="organizationContact.city" cssClass="control-label alert alert-danger" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="organizationContact.address">Ünvan</form:label>
                                <form:input path="organizationContact.address" cssClass="form-control" placeholder="Küçə adı, ev nömrəsi və s."/>
                                <form:errors path="organizationContact.address" cssClass="control-label alert alert-danger" />
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="$('#form').submit()">Yadda saxla</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/assets/vendors/custom/jstree/jstree.bundle.js" />" type="text/javascript"></script>
<script src="<c:url value="/assets/js/demo4/pages/components/extended/treeview.js" />" type="text/javascript"></script>
<script>
    function show(data){
        var json = {"id":3,"name":"Baş ofis","description":"Baş ofis","createdDate":1567875963000,"active":true};
        var d = JSON.stringify(json, null, 2)
        alert(data);
        alert(d);
        console.log(d);
    }
</script>

