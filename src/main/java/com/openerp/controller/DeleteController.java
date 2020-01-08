package com.openerp.controller;

import com.openerp.entity.*;
import com.openerp.repository.ModuleRepository;
import com.openerp.specification.internal.Filter;
import com.openerp.util.Constants;
import com.openerp.util.*;
import org.aspectj.weaver.ast.Or;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/delete")
public class DeleteController extends SkeletonController {

    @PostMapping(value = "/{path}")
    public String getSubModules(RedirectAttributes redirectAttributes, @PathVariable("path") String path, @RequestParam(name="deletedId", defaultValue = "0") String id) throws Exception {
        User user = getSessionUser();
        String parent = "admin";
        for(UserModuleOperation umo: user.getUserModuleOperations()){
            if(umo.getModuleOperation()!=null && umo.getModuleOperation().getModule()!=null
                    && umo.getModuleOperation().getModule().getPath().equalsIgnoreCase(path)){
                if(umo.getModuleOperation().getModule().getModule()==null){
                    parent = umo.getModuleOperation().getModule().getPath();
                } else if(umo.getModuleOperation().getModule().getModule().getModule()==null) {
                    parent = umo.getModuleOperation().getModule().getModule().getPath();
                } else if(umo.getModuleOperation().getModule().getModule().getModule().getModule()==null) {
                    parent = umo.getModuleOperation().getModule().getModule().getModule().getPath();
                }
                break;
            }

        }
        redirectAttributes.addFlashAttribute(Constants.STATUS.RESPONSE, Util.response(null, Constants.TEXT.SUCCESS));
        if(path.equalsIgnoreCase(Constants.ROUTE.DICTIONARY_TYPE)){
            DictionaryType dictionaryType = dictionaryTypeRepository.getDictionaryTypeById(Integer.parseInt(id));
            dictionaryType.setActive(false);
            dictionaryTypeRepository.save(dictionaryType);
            log("admin_dictionary_type", "create/edit", dictionaryType.getId(), dictionaryType.toString());
            if(dictionaryType!=null){
                for(Dictionary dictionary: dictionaryRepository.getDictionariesByDictionaryType_Id(dictionaryType.getId())){
                    dictionary.setActive(false);
                    dictionaryRepository.save(dictionary);
                    log("admin_dictionary_type", "create/edit", dictionary.getId(), dictionary.toString());
                }
            }
        } else if(path.equalsIgnoreCase(Constants.ROUTE.DICTIONARY)){
            Dictionary dictionary = dictionaryRepository.getDictionaryById(Integer.parseInt(id));
            dictionary.setActive(false);
            dictionaryRepository.save(dictionary);
            log("admin_dictionary", "create/edit", dictionary.getId(), dictionary.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.MODULE)){
            Module module = moduleRepository.getModuleById(Integer.parseInt(id));
            module.setActive(false);
            moduleRepository.save(module);
            log("admin_module", "create/edit", module.getId(), module.toString());
            for(ModuleOperation moduleOperation: moduleOperationRepository.getModuleOperationsByModule_Active(false)){
                userModuleOperationRepository.deleteInBatch(userModuleOperationRepository.getUserModuleOperationsByModuleOperation_Id(moduleOperation.getId()));
                log("admin_user_module_operation", "delete-in-batch", moduleOperation.getId(), moduleOperation.toString());
                moduleOperationRepository.deleteById(moduleOperation.getId());
                log("admin_module_operation", "delete", moduleOperation.getId(), moduleOperation.toString());
            }
        } else if(path.equalsIgnoreCase(Constants.ROUTE.OPERATION)){
            Operation operation = operationRepository.getOperationById(Integer.parseInt(id));
            operation.setActive(false);
            operationRepository.save(operation);
            log("admin_operation", "create/edit", operation.getId(), operation.toString());
            for(ModuleOperation moduleOperation: moduleOperationRepository.getModuleOperationsByOperation_Active(false)){
                userModuleOperationRepository.deleteInBatch(userModuleOperationRepository.getUserModuleOperationsByModuleOperation_Id(moduleOperation.getId()));
                log("admin_operation", "delete-in-batch", operation.getId(), operation.toString());
                moduleOperationRepository.deleteById(moduleOperation.getId());
                log("admin_module_operation", "delete", moduleOperation.getId(), moduleOperation.toString());
            }
        } else if(path.equalsIgnoreCase(Constants.ROUTE.MODULE_OPERATION)){
            Module module = moduleRepository.getModuleById(Integer.parseInt(id));
            log("admin_module_operation", "delete", module.getId(), module.toString());
            moduleRepository.delete(module);

        } else if(path.equalsIgnoreCase(Constants.ROUTE.USER_MODULE_OPERATION)){
            User userObject = userRepository.getUserByActiveTrueAndId(Integer.parseInt(id));
            userRepository.save(userObject);
            log("admin_user", "create/edit", userObject.getId(), userObject.toString());
            List<UserModuleOperation> userModuleOperations = userModuleOperationRepository.getUserModuleOperationsByUser_IdAndUser_Active(user.getId(), true);
            userModuleOperationRepository.deleteInBatch(userModuleOperations);
            //Listin icinde nie metod hell etmek olmur
            //log("admin_user_module_operation", "delete-in-batch", userModuleOperations.getId(), userModuleOperations.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.EMPLOYEE)){
            Employee employee = employeeRepository.getEmployeeById(Integer.parseInt(id));
            log("admin_module_operation", "delete", employee.getId(), employee.toString());
            employeeRepository.delete(employee);
        } else if(path.equalsIgnoreCase(Constants.ROUTE.ORGANIZATION)){
            Organization organization = organizationRepository.getOrganizationByIdAndActiveTrue(Integer.parseInt(id));
            log("admin_module_operation", "delete", organization.getId(), organization.toString());
            organizationRepository.delete(organization);
        } else if(path.equalsIgnoreCase(Constants.ROUTE.SUPPLIER)){
            Supplier supplier = supplierRepository.getSuppliersById(Integer.parseInt(id));
            supplier.setActive(false);
            supplierRepository.save(supplier);
            log("warehouse_supplier", "create/edit", supplier.getId(), supplier.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.ACCOUNT)){
            Account account = accountRepository.getAccountById(Integer.parseInt(id));
            account.setActive(false);
            accountRepository.save(account);
            log("accounting_account", "create/edit", account.getId(), account.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.NON_WORKING_DAY)){
            NonWorkingDay nonWorkingDay = nonWorkingDayRepository.getNonWorkingDayById(Integer.parseInt(id));
            nonWorkingDay.setActive(false);
            nonWorkingDayRepository.save(nonWorkingDay);
            log("hr_non_working_day", "create/edit", nonWorkingDay.getId(), nonWorkingDay.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.SHORTENED_WORKING_DAY)){
            ShortenedWorkingDay shortenedWorkingDay = shortenedWorkingDayRepository.getShortenedWorkingDayById(Integer.parseInt(id));
            shortenedWorkingDay.setActive(false);
            shortenedWorkingDayRepository.save(shortenedWorkingDay);
            log("hr_shortened_working_day", "create/edit", shortenedWorkingDay.getId(), shortenedWorkingDay.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.PAYROLL_CONFIGURATION)){
            PayrollConfiguration payrollConfiguration = payrollConfigurationRepository.getPayrollConfigurationById(Integer.parseInt(id));
            payrollConfiguration.setActive(false);
            payrollConfigurationRepository.save(payrollConfiguration);
            log("payroll_configuration", "create/edit", payrollConfiguration.getId(), payrollConfiguration.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.VACATION)){
            Vacation vacation = vacationRepository.getVacationById(Integer.parseInt(id));
            vacation.setActive(false);
            vacationRepository.save(vacation);
            log("hr_vacation", "create/edit", vacation.getId(), vacation.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.WORKING_HOUR_RECORD)){
            WorkingHourRecord workingHourRecord = workingHourRecordRepository.getWorkingHourRecordById(Integer.parseInt(id));
            workingHourRecord.setActive(false);
            workingHourRecordRepository.save(workingHourRecord);
            log("payroll_working_hour_record", "create/edit", workingHourRecord.getId(), workingHourRecord.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.SALARY)){
            Salary salary = salaryRepository.getSalaryById(Integer.parseInt(id));
            salary.setActive(false);
            salaryRepository.save(salary);
            log("payroll_salary", "create/edit", salary.getId(), salary.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.ADVANCE)){
            Advance advance = advanceRepository.getAdvanceById(Integer.parseInt(id));
            advance.setActive(false);
            advanceRepository.save(advance);
            log("payroll_advance", "create/edit", advance.getId(), advance.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.INVENTORY)){
            Inventory inventory = inventoryRepository.getInventoryById(Integer.parseInt(id));
            inventory.setActive(false);
            inventoryRepository.save(inventory);
            log("warehouse_inventory", "create/edit", inventory.getId(), inventory.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.ACTION)){
            Action action = actionRepository.getActionById(Integer.parseInt(id));
            action.setActive(false);
            actionRepository.save(action);
            log("warehouse_action", "create/edit", action.getId(), action.toString());
            List<Action> actions = actionRepository.getActionsByActiveTrueAndInventory_IdAndInventory_ActiveAndActionOrderByIdDesc(action.getInventory().getId(), true, dictionaryRepository.getDictionaryByAttr1AndActiveTrueAndDictionaryType_Attr1("buy", "action"));
            if(actions.size()>0){
                Action returnAction = actions.get(0);
                returnAction.setAmount(returnAction.getAmount()+action.getAmount());
                actionRepository.save(returnAction);
                log("warehouse_action", "create/edit", returnAction.getId(), returnAction.toString());
            }
            return "redirect:/"+parent+"/"+path+"/"+action.getInventory().getId();
        } else if(path.equalsIgnoreCase(Constants.ROUTE.ITEM)){
            Item item = itemRepository.getItemById(Integer.parseInt(id));
            item.setActive(false);
            itemRepository.save(item);
            log("idgroup_item", "create/edit", item.getId(), item.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.PAYMENT_REGULATOR_NOTE)){
            PaymentRegulatorNote paymentRegulatorNote = paymentRegulatorNoteRepository.getPaymentRegulatorNoteById(Integer.parseInt(id));
            paymentRegulatorNote.setActive(false);
            paymentRegulatorNoteRepository.save(paymentRegulatorNote);
            log("collect_payment_regulator_note", "delete", paymentRegulatorNote.getId(), paymentRegulatorNote.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.CUSTOMER)){
            Customer customer = customerRepository.getCustomerByIdAndActiveTrue(Integer.parseInt(id));
            customer.setActive(false);
            customerRepository.save(customer);
            log("crm_customer", "create/edit", customer.getId(), customer.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.CONFIGURATION)){
            Configuration configuration = configurationRepository.getConfigurationById(Integer.parseInt(id));
            configuration.setActive(false);
            configurationRepository.save(configuration);
            log("admin_configuration", "create/edit", configuration.getId(), configuration.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.NOTIFICATION)){
            Notification notification = notificationRepository.getNotificationById(Integer.parseInt(id));
            log("admin_configuration", "delete", notification.getId(), notification.toString());
            notificationRepository.delete(notification);
        } else if(path.equalsIgnoreCase(Constants.ROUTE.FINANCING)){
            Financing financing = financingRepository.getFinancingById(Integer.parseInt(id));
            financing.setActive(false);
            financingRepository.save(financing);
            log("accounting_financing", "create/edit", financing.getId(), financing.toString());
        } else if(path.equalsIgnoreCase(Constants.ROUTE.LOG)){
            Log log = logRepository.getLogById(Integer.parseInt(id));
            log.setActive(false);
            logRepository.save(log);
            log("admin_log", "delete", log.getId(), log.toString());
        }
        return "redirect:/"+parent+"/"+path;
    }
}
