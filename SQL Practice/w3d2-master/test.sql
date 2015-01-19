SELECT
  *
FROM
  questions

  q.id IN (
  SELECT
    qf.question_id
  FROM
    question_followers AS qf
  GROUP BY
    qf.question_id
  ORDER BY
    COUNT(qf.question_id) DESC
  LIMIT ?
  )
