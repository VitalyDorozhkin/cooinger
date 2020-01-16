package ru.pparalax.cooinger.repos;

import org.springframework.data.repository.CrudRepository;
import ru.pparalax.cooinger.domain.Message;

import java.util.List;

public interface MessageRepo extends CrudRepository<Message, Long> {
    List<Message> findByTag(String tag);
}
