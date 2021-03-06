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
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <c:set var="delete" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'delete')}"/>
    <c:set var="filter" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'filter')}"/>
    <c:if test="${filter.status}">
        <div class="accordion  accordion-toggle-arrow mb-2" id="accordionFilter">
            <div class="card" style="border-radius: 4px;">
                <div class="card-header">
                    <div class="card-title w-100" data-toggle="collapse" data-target="#filterContent" aria-expanded="true" aria-controls="collapseOne4">
                        <div class="row w-100">
                            <div class="col-3">
                                <i class="<c:out value="${filter.object.icon}"/>"></i>
                                <c:out value="${list.totalElements>0?list.totalElements:0} sətr"/>
                            </div>
                            <div class="col-6 text-center" style="letter-spacing: 10px;">
                                <c:out value="${filter.object.name}"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="filterContent" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionFilter">
                    <div class="card-body">
                        <form:form modelAttribute="filter" id="filter" method="post" action="/admin/log/filter">
                            <div class="row">
                                <div class="col-md-11">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="id">KOD</form:label>
                                                <form:input path="id" cssClass="form-control" placeholder="######"/>
                                                <form:errors path="id" cssClass="control-label alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="type">Tip</form:label>
                                                <form:input path="type" cssClass="form-control" placeholder="Tip \'info' və ya 'error' ola bilər"/>
                                                <form:errors path="type" cssClass="alert-danger control-label"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="tableName">Cədvəl</form:label>
                                                <form:input path="tableName" cssClass="form-control" placeholder="Cədvəli daxil edin" />
                                                <form:errors path="tableName" cssClass="alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="operation">Əməliyyat</form:label>
                                                <form:input path="operation" cssClass="form-control" placeholder="Əməliyyatı daxil edin" />
                                                <form:errors path="operation" cssClass="alert alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="rowId">Sətr №</form:label>
                                                <form:input path="rowId" cssClass="form-control" placeholder="Sətr №-sini daxil edin" />
                                                <form:errors path="rowId" cssClass="alert alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="description">Açıqlama</form:label>
                                                <form:input path="description" cssClass="form-control" placeholder="Açıqlamanı daxil edin" />
                                                <form:errors path="description" cssClass="alert alert-danger"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="username">İstifadəçi adı</form:label>
                                                <form:input path="username" cssClass="form-control" placeholder="Əməliyyatı daxil edin" />
                                                <form:errors path="username" cssClass="alert alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="operationDateFrom">Tarixdən</form:label>
                                                <div class="input-group date">
                                                    <form:input path="operationDateFrom" autocomplete="off"
                                                                cssClass="form-control datetimepicker-element" date_="datetime_"
                                                                placeholder="dd.MM.yyyy HH:mm"/>
                                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="la la-calendar"></i>
                                        </span>
                                                    </div>
                                                </div>
                                                <form:errors path="operationDateFrom" cssClass="control-label alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="operationDate">Tarixədək</form:label>
                                                <div class="input-group date">
                                                    <form:input path="operationDate" autocomplete="off"
                                                                cssClass="form-control datetimepicker-element" date_="datetime_"
                                                                placeholder="dd.MM.yyyy HH:mm"/>
                                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="la la-calendar"></i>
                                        </span>
                                                    </div>
                                                </div>
                                                <form:errors path="operationDate" cssClass="control-label alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="encapsulate">Enkapsulyasiya</form:label>
                                                <form:input path="encapsulate" cssClass="form-control" placeholder="Daxil edin" />
                                                <form:errors path="encapsulate" cssClass="alert alert-danger"/>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <form:label path="json">JSON</form:label>
                                                <form:input path="json" cssClass="form-control" placeholder="Daxil edin" />
                                                <form:errors path="json" cssClass="alert alert-danger"/>
                                            </div>
                                        </div>
                                        <c:if test="${delete.status}">
                                            <div class="col-md-2" style="padding-top: 30px;">
                                                <div class="form-group">
                                                    <label class="kt-checkbox kt-checkbox--brand">
                                                        <form:checkbox path="active"/> Aktual məlumat
                                                        <span></span>
                                                    </label>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-1 text-right">
                                    <div class="form-group">
                                        <a href="#" onclick="location.reload();" class="btn btn-danger btn-elevate btn-icon-sm btn-block mb-2" style="padding: 0.35rem 0.6rem;">
                                            <i class="la la-trash"></i> Sil
                                        </a>
                                        <a href="#" onclick="submit($('#filter'))" class="btn btn-warning btn-elevate btn-icon-sm btn-block mt-2" style="padding: 0.35rem 0.6rem">
                                            <i class="la la-search"></i> Axtar
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <div class="row">
        <div class="col-lg-12">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">

<c:choose>
    <c:when test="${not empty list}">
    <c:set var="view" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'view')}"/>
    <c:set var="export" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'export')}"/>
    <c:set var="detail" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'detail')}"/>
    <c:set var="edit" value="${utl:checkOperation(sessionScope.user.userModuleOperations, page, 'edit')}"/>
    <table class="table table-striped- table-bordered table-hover table-checkable" id="datatable">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tip</th>
        <th>Cədvəl</th>
        <th>Əməliyyat</th>
        <th>Yazı №</th>
        <th>Açıqlama</th>
        <th>Tarix</th>
        <th>İstifadəçi</th>
        <th>Əməliyyat</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="t" items="${list.content}" varStatus="loop">
        <tr data="<c:out value="${utl:toJson(t)}" />"
                <c:if test="${t.type eq 'error'}">
                    style="background-color: #ffeaf1 !important"
                </c:if>
        >
            <td><c:out value="${t.id}" /></td>
            <td><c:out value="${t.type}" /></td>
            <th><c:out value="${t.tableName}" /></th>
            <th><c:out value="${t.operation}" /></th>
            <td><c:out value="${t.rowId}" /></td>
            <td><c:out value="${t.description}" /></td>
            <td><fmt:formatDate value = "${t.operationDate}" pattern = "dd.MM.yyyy HH:mm:ss" /></td>
            <td><c:out value="${t.username}" /></td>
            <td nowrap class="text-center">
                <c:if test="${view.status}">
                    <a href="javascript:view($('#form'), '<c:out value="${utl:toJson(t)}" />', 'modal-operation', '<c:out value="${view.object.name}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${view.object.name}"/>">
                        <i class="<c:out value="${view.object.icon}"/>"></i>
                    </a>
                </c:if>
                <c:if test="${detail.status}">
                    <a href="javascript:detail('<c:out value="${t.id}" />', $('#detail-modal-operation'));" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${detail.object.name}"/>">
                        <i class="<c:out value="${detail.object.icon}"/>"></i>
                    </a>
                </c:if>
                <c:if test="${edit.status}">
                    <a href="javascript:edit($('#form'), '<c:out value="${utl:toJson(t)}" />', 'modal-operation', '<c:out value="${edit.object.name}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${edit.object.name}"/>">
                        <i class="<c:out value="${edit.object.icon}"/>"></i>
                    </a>
                </c:if>
                <c:if test="${delete.status}">
                    <a href="javascript:deleteData('<c:out value="${t.id}" />', '<c:out value="${t.operation}" /><br/><c:out value="${t.description}" />');" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="<c:out value="${delete.object.name}"/>">
                        <i class="<c:out value="${delete.object.icon}"/>"></i>
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" id="form" method="post" action="/admin/log" cssClass="form-group">
                    <form:hidden path="id"/>
                    <form:hidden path="active"/>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="type">Tip</form:label>
                                <form:input path="type" cssClass="form-control" placeholder="Tip \'info' və ya 'error' ola bilər"/>
                                <form:errors path="type" cssClass="alert-danger control-label"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="tableName">Cədvəl</form:label>
                                <form:input path="tableName" cssClass="form-control" placeholder="Cədvəli daxil edin" />
                                <form:errors path="tableName" cssClass="alert-danger"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="operation">Əməliyyat</form:label>
                                <form:input path="operation" cssClass="form-control" placeholder="Əməliyyatı daxil edin" />
                                <form:errors path="operation" cssClass="alert alert-danger"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <form:label path="rowId">Sətr №</form:label>
                                <form:input path="rowId" cssClass="form-control" placeholder="Sətr №-sini daxil edin" />
                                <form:errors path="rowId" cssClass="alert alert-danger"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <form:label path="description">Açıqlama</form:label>
                        <form:textarea path="description" cssClass="form-control" placeholder="Açıqlamanı daxil edin" />
                        <form:errors path="description" cssClass="alert alert-danger"/>
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

<div class="modal fade" id="detail-modal-operation" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detal</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row bg-light text-center">
                    <div class="col-md-12">
                        <label id="label-info"></label>
                    </div>
                </div>
                <div class="row mt-4 mb-2 bg-light text-center">
                    <div class="col-md-12" style="letter-spacing: 10px; font-weight: bold">
                        JSON
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label id="label-json" style="width: 100%"></label>
                    </div>
                </div>
                <div class="row mt-4 mb-2 bg-light text-center">
                    <div class="col-md-12" style="letter-spacing: 10px; font-weight: bold;">
                        Enkapsulyasiya
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label id="label-encapsulate" style="width: 100%"></label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('#datatable tbody').on('dblclick', 'tr', function () {
        <c:if test="${view.status}">
            view($('#form'), $(this).attr('data'), 'modal-operation', '<c:out value="${view.object.name}" />');
        </c:if>
    });

    $("#datatable").DataTable({
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
        lengthMenu: [10, 25, 50, 75, 100, 200, 1000],
        pageLength: 100,
        order: [[1, 'desc']],
        columnDefs: [
            {
                targets: 0,
                width: '25px',
                className: 'dt-center',
                orderable: false
            },
        ],
    });

    $( "#form" ).validate({
        rules: {
            type: {
                required: true
            },
            operation: {
                required: true
            }
        },
        invalidHandler: function(event, validator) {
                    KTUtil.scrollTop();
            swal.close();
        },
    });

    $("input[name='rowId']").inputmask('decimal', {
        rightAlignNumerics: false
    });

    function detail(id, modal){
        swal.fire({
            text: 'Proses davam edir...',
            allowOutsideClick: false,
            onOpen: function() {
                swal.showLoading();
                $.ajax({
                    url: '/admin/log/id/'+id,
                    type: 'GET',
                    dataType: 'json',
                    beforeSend: function() {
                        $(modal).find("#label-info").text('');
                        $(modal).find("#label-encapsulate").text('');
                        $(modal).find("#label-json").text('');
                    },
                    success: function(data) {
                        $(modal).find("#label-info").text(data.id);
                        $(modal).find("#label-encapsulate").text(data.encapsulateTransient);
                        $(modal).find("#label-json").text(data.jsonTransient);
                        $(modal).modal('toggle');
                        swal.close();
                    },
                    error: function() {
                        swal.fire({
                            title: "Xəta baş verdi!",
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


