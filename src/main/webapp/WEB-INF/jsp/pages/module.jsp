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
<%@ taglib prefix="ua" uri="/WEB-INF/tld/UserAccess.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="<c:url value="/assets/vendors/custom/jstree/jstree.bundle.css" />" rel="stylesheet" type="text/css" />
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <div class="row">

        <div class="col-lg-6">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">
                    <div id="kt_tree_5" class="tree-demo">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">
                    Menyunun yer alacağı kontent: Menyuya baxış
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
                <form:form modelAttribute="form" id="form" method="post" action="/admin/module" cssClass="form-group">
                    <div class="form-group">
                        <form:label path="module">Üst modul</form:label>
                        <form:select  path="module" cssClass="custom-select form-control">
                            <form:options items="${list}" itemLabel="name" itemValue="id" />
                        </form:select>
                    </div>
                    <div class="form-group">
                        <form:label path="name">Ad</form:label>
                        <form:input path="name" type="text" cssClass="form-control" placeholder="Modulun adını daxil edin" />
                        <form:errors path="name" cssClass="alert-danger control-label"/>
                    </div>
                    <div class="form-group">
                        <form:label path="description">Açıqlama</form:label>
                        <form:input path="description" type="text" cssClass="form-control" placeholder="Modul açıqlamasını daxil edin" />
                    </div>
                    <div class="form-group">
                        <form:label path="path">URL Path</form:label>
                        <form:input path="path" type="text" cssClass="form-control" placeholder="Modul path daxil edin" />
                    </div>
                    <div class="form-group">
                        <form:label path="icon">İkon</form:label>
                        <form:input path="icon" type="text" cssClass="form-control" placeholder="İkon adını daxil edin" />
                        <form:errors path="icon" cssClass="alert-danger control-label"/>
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
<script>
    function show(data){
        let json = data;
        let d = JSON.stringify(json, null, 2);
        alert(data);
        alert(d);
        console.log(d);
    }

    $(function(){
        var KTTreeview = function () {
            var demo5 = function() {
                $("#kt_tree_5").jstree({
                    "core" : {
                        "themes" : {
                            "responsive": false
                        },
                        // so that create works
                        "check_callback" : true,
                        'data': [{
                            "text": "Parent Node",
                            "children": [{
                                "text": "Initially selected",
                                "state": {
                                    "selected": true
                                }
                            }, {
                                "text": "Custom Icon",
                                "icon": "fa fa-warning kt-font-danger"
                            }, {
                                "text": "Initially open",
                                "icon" : "fa fa-folder kt-font-success",
                                "state": {
                                    "opened": true
                                },
                                "children": [
                                    {"text": "Another node", "icon" : "fa fa-file kt-font-waring"}
                                ]
                            }, {
                                "text": "Another Custom Icon",
                                "icon": "fa fa-warning kt-font-waring"
                            }, {
                                "text": "Disabled Node",
                                "icon": "fa fa-check kt-font-success",
                                "state": {
                                    "disabled": true
                                }
                            }, {
                                "text": "Sub Nodes",
                                "icon": "fa fa-folder kt-font-danger",
                                "children": [
                                    {"text": "Item 1", "icon" : "fa fa-file kt-font-waring"},
                                    {"text": "Item 2", "icon" : "fa fa-file kt-font-success"},
                                    {"text": "Item 3", "icon" : "fa fa-file kt-font-default"},
                                    {"text": "Item 4", "icon" : "fa fa-file kt-font-danger"},
                                    {"text": "Item 5", "icon" : "fa fa-file kt-font-info"}
                                ]
                            }]
                        },
                            "Another Node"
                        ]
                    },
                    "types" : {
                        "default" : {
                            "icon" : "fa fa-folder kt-font-success"
                        },
                        "file" : {
                            "icon" : "fa fa-file  kt-font-success"
                        }
                    },
                    "state" : { "key" : "demo2" },
                    "plugins" : [ "dnd", "state", "types" ]
                });
            };
            return {
                init: function () {
                    demo5();
                }
            };
        }();

        KTTreeview.init();
    })


</script>

